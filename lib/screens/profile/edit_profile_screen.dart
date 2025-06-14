import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb, Uint8List;
import 'package:flutter/material.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/core/app_logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:go_router/go_router.dart'; // For navigation
import 'package:image_picker/image_picker.dart'; // Import image_picker
import 'package:firebase_storage/firebase_storage.dart'; // Import Firebase Storage
import 'package:vet_mobile_app/core/app_back_button.dart'; // AppBackButton'ду импорттоо (эгер жолу ушундай болсо)

// Helper widget for editable avatar
class _EditableAvatarWidget extends StatelessWidget {
  final String? avatarUrl;
  final VoidCallback onEditPressed;
  final File? imageFile;
  final Uint8List? webImage; // Add this for web images

  const _EditableAvatarWidget({
    this.avatarUrl,
    required this.onEditPressed,
    this.imageFile,
    this.webImage, // Add this
  });

  // Платформага карап, туура ImageProvider кайтаруу
  ImageProvider? _getImageProvider() {
    if (webImage != null) {
      return MemoryImage(webImage!);
    } else if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      return NetworkImage(avatarUrl!);
    }
    return null;
  }

  // Демейки иконканы көрсөтүү керекпи
  bool _shouldShowDefaultIcon() {
    return webImage == null && (avatarUrl == null || avatarUrl!.isEmpty);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.primary,
                width: 1,
              ),
            ),
            child: ClipOval( // CircleAvatar'дын ордуна ClipOval + Container колдонуу
              child: webImage != null 
                ? Image.memory(
                    webImage!, 
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover, // Маанилүү: cover колдонуу
                  )
                : avatarUrl != null && avatarUrl!.isNotEmpty
                    ? Image.network(
                        avatarUrl!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover, // Маанилүү: cover колдонуу
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.person, size: 50, color: AppColors.primary);
                        },
                      )
                    : Container(
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.person, size: 50, color: AppColors.primary),
                      ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
              ),
              child: IconButton(
                icon: const Icon(Icons.edit, color: Colors.white, size: 20),
                onPressed: onEditPressed,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper widget for profile text fields
class _ProfileTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;

  const _ProfileTextFieldWidget({
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.validator,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText, style: AppTextStyles.bodySmall),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Sizes.inputRadius),
              borderSide: BorderSide(color: AppColors.primary.withOpacity(0.2)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Sizes.inputRadius),
              borderSide: BorderSide(color: AppColors.primary.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Sizes.inputRadius),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
          ),
          validator: validator,
          onTap: onTap,
        ),
      ],
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _dateController;
  String? _avatarUrl; 
  File? _pickedImageFile; // To store the picked image file

  bool _isLoading = true;
  String? _errorMessage;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance; // Firebase Storage instance
  User? _currentUser;

  // Бул өзгөртүү коддун структурасын бузбайт, фреймворк ката берген жерди гана оңдойт
  Uint8List? _webImage;
  String? _imageUrl;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _dateController = TextEditingController();
    _currentUser = _auth.currentUser;
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    if (_currentUser == null) {
      if (!mounted) return; // Add mounted check
      setState(() {
        _isLoading = false;
        _errorMessage = "Колдонуучу табылган жок. Сураныч, кайра кириңиз.";
      });
      return;
    }

    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc =
          await _firestore.collection('users').doc(_currentUser!.uid).get();

      if (userDoc.exists) {
        final userData = userDoc.data()!;
        _nameController.text = userData['fullName'] ?? '';
        
        if (userData['dateOfBirth'] != null && userData['dateOfBirth'] is Timestamp) {
          final Timestamp dobTimestamp = userData['dateOfBirth'];
          final DateTime dobDate = dobTimestamp.toDate();
          final DateFormat formatter = DateFormat('d MMMM, yyyy', 'ru'); // Кыргызча үчүн 'ky' колдонсоңуз болот
          _dateController.text = formatter.format(dobDate);
        } else {
          _dateController.text = '';
        }
        // БУРЧТУК: Сүрөт URL текшерүү
        if (userData['avatarUrl'] != null && userData['avatarUrl'].isNotEmpty) {
          setState(() {
            _avatarUrl = userData['avatarUrl'];
          });
        } else {
          // Default URL колдонуу же null калтыруу
          setState(() {
            _avatarUrl = null;
          });
        }
      } else {
        if (!mounted) return; // Add mounted check
        _errorMessage = "Колдонуучунун маалыматтары табылган жок.";
      }
    } catch (e) {
      if (!mounted) return; // Add mounted check
      _errorMessage = "Маалыматтарды жүктөөдө ката кетти: $e";
    } finally {
      if (!mounted) return; // Add mounted check
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        if (kIsWeb) {
          // Веб үчүн сүрөт тандоо коду
          _webImage = await pickedFile.readAsBytes();
          setState(() {});
        } else {
          // Мобилдик версияда
          setState(() {
            _pickedImageFile = File(pickedFile.path);
          });
        }
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Сүрөт тандоодо ката кетти: $e")),
      );
    }
  }

  // Сүрөт көрсөтүү виджети
  Widget _buildImageWidget() {
    // Веб жана мобилдик режимде бирдей иштөө үчүн
    if (_webImage != null) {
      return Image.memory(_webImage!);
    } else if ((_avatarUrl != null && _avatarUrl!.isNotEmpty)) {
      return Image.network(
        _avatarUrl!,
        errorBuilder: (context, error, stackTrace) {
          print('Network image error: $error');
          return Image.asset('assets/icons/common/logo.png');
        },
      );
    } else {
      return Image.asset('assets/icons/common/logo.png'); // Стандарт сүрөт
    }
  }

  Future<String?> _uploadImage(File imageFile) async {
    if (_currentUser == null) return null;
    try {
      final String fileName = 'profile_pictures/${_currentUser!.uid}/${DateTime.now().millisecondsSinceEpoch}.${imageFile.path.split('.').last}';
      final Reference storageRef = _storage.ref().child(fileName);
      final UploadTask uploadTask = storageRef.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      if (!mounted) return null;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Сүрөттү жүктөөдө ката кетти: $e")),
      );
      return null;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    // Ensure mounted before initial setState
    if (!mounted) return;
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    if (_currentUser == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Колдонуучу табылган жок. Сактоо мүмкүн эмес.")),
      );
      if (!mounted) return; // Check again before setState
      setState(() => _isLoading = false);
      return;
    }

    try {
      String? newAvatarUrl = _avatarUrl; // Учурдагы URL менен баштоо
      if (_pickedImageFile != null) {
        newAvatarUrl = await _uploadImage(_pickedImageFile!);
        if (newAvatarUrl == null) {
          // Ката _uploadImage ичинде көрсөтүлөт
          if (!mounted) return;
          setState(() => _isLoading = false);
          return;
        }
      }

      final Map<String, dynamic> updatedData = {
        'fullName': _nameController.text.trim(),
        // newAvatarUrl null болсо да, эгер мурда _avatarUrl бар болсо, ошол калат.
        // Эгер жаңы сүрөт жүктөлсө, newAvatarUrl жаңы маанини алат.
        // Эгер сүрөт өчүрүлсө, анда 'avatarUrl': FieldValue.delete() колдонсо болот.
        // Азыркы логикада, эгер жаңы сүрөт тандалбаса, эски URL сакталат.
        // Эгер жаңы сүрөт тандалып, жүктөлсө, жаңы URL сакталат.
        'avatarUrl': newAvatarUrl, 
      };

      if (_dateController.text.isNotEmpty) {
        try {
          final DateFormat inputFormat = DateFormat('d MMMM, yyyy', 'ru');
          final DateTime parsedDate = inputFormat.parseLoose(_dateController.text);
          updatedData['dateOfBirth'] = Timestamp.fromDate(parsedDate);
        } catch (e) {
           if (!mounted) return;
           ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Туулган дата форматы туура эмес: ${_dateController.text}")),
          );
           if (!mounted) return;
          setState(() => _isLoading = false);
          return;
        }
      } else {
        // Эгер дата талаасы бош болсо, Firestore'догу маанини null кылуу
        updatedData['dateOfBirth'] = null; 
      }

      await _firestore.collection('users').doc(_currentUser!.uid).update(updatedData);

      if (!mounted) return; // Added check

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Профиль ийгиликтүү сакталды!")),
      );
      if (mounted) { // This check is fine
        context.pop();
      }
    } catch (e) {
      if (!mounted) return; // Added check
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Профилди сактоодо ката кетти: $e")),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
  Future<void> _selectDate(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode()); 
    DateTime initialDate = DateTime.now();
    if (_dateController.text.isNotEmpty) {
      try {
        final DateFormat inputFormat = DateFormat('d MMMM, yyyy', 'ru'); 
        initialDate = inputFormat.parseLoose(_dateController.text);
      } catch (e) {
        // Ката кетсе, демейки датаны колдонуу
      }
    }

    final DateTime? picked = await showDatePicker( // picked өзгөрмөсүн DateTime? кылуу
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('ru', ''), // Же 'ky'
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.textPrimary,
            ), dialogTheme: DialogThemeData(backgroundColor: Colors.white), // dialogTheme ордуна
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      if (!mounted) return; // mounted текшерүүсү
      final DateFormat formatter = DateFormat('d MMMM, yyyy', 'ru'); // Же 'ky'
      setState(() { // setState ичинде _dateController.text'ти жаңыртуу
        _dateController.text = formatter.format(picked);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: AppBackButton( // IconButton'дун ордуна AppBackButton
          onPressed: () { // AppBackButton'га onPressed функциясын берүү
            if (context.canPop()) {
              context.pop();
            } else {
              // Эгер артка кайтуу мүмкүн болбосо, мисалы, профиль экранына өтүү
              // GoRouter.of(context).go(RouteNames.profile); // Же тиешелүү башка жол
            }
          },
          // Эгер AppBackButton'дун ичинде демейки иконка болсо,
          // icon параметрин берүүнүн кажети жок.
          // Эгер иконканы өзгөрткүңүз келсе, жана AppBackButton icon параметрин алса:
          // icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary), 
        ),
        title: const Text(
          'Профилди оңдоо',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: Sizes.padding),
            child: AppLogo(),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
                ))
              : Form(
                  key: _formKey,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    children: [
                      const SizedBox(height: 30),
                      _EditableAvatarWidget(
                        avatarUrl: _avatarUrl,
                        imageFile: kIsWeb ? null : _pickedImageFile,  // Only use on mobile
                        webImage: _webImage,  // Use for web
                        onEditPressed: _pickImage,
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: ValueListenableBuilder<TextEditingValue>(
                          valueListenable: _nameController,
                          builder: (context, value, child) {
                            return Text(
                              value.text.isNotEmpty ? value.text : (_currentUser?.displayName ?? 'Аты-жөнү'), // Firebase'ден алынган displayName'ди да көрсөтүү
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                              textAlign: TextAlign.center,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 32),
                      _ProfileTextFieldWidget(
                        controller: _nameController,
                        labelText: 'Толук аты',
                        hintText: 'Толук атыңызды жазыңыз',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Толук атыңызды киргизиңиз';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      _ProfileTextFieldWidget(
                        controller: _dateController,
                        labelText: 'Туулган датасы',
                        hintText: 'кк.aaaa.жжжж', // Форматты тактоо
                        readOnly: true,
                        suffixIcon: const Icon(Icons.calendar_today, color: AppColors.primary),
                        onTap: () => _selectDate(context),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(Sizes.buttonRadius),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          onPressed: _isLoading ? null : _saveProfile,
                          child: _isLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(Colors.white)),
                                )
                              : const Text('Сактоо', style: TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
    );
  }
}