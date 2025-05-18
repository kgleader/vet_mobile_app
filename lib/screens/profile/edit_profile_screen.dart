import 'dart:io'; // Import for File
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

// Helper widget for editable avatar
class _EditableAvatarWidget extends StatelessWidget {
  final String? avatarUrl;
  final VoidCallback onEditPressed;
  final File? imageFile; // Add this to display picked image

  const _EditableAvatarWidget({
    this.avatarUrl,
    required this.onEditPressed,
    this.imageFile, // Add this
  });

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
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: imageFile != null
                  ? FileImage(imageFile!)
                  : (avatarUrl != null && avatarUrl!.isNotEmpty ? NetworkImage(avatarUrl!) : null) as ImageProvider?,
              child: imageFile == null && (avatarUrl == null || avatarUrl!.isEmpty)
                  ? const Icon(Icons.person, size: 50, color: AppColors.primary)
                  : null,
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
          final DateFormat formatter = DateFormat('d MMMM, yyyy', 'ru');
          _dateController.text = formatter.format(dobDate);
        } else {
          _dateController.text = '';
        }
        _avatarUrl = userData['avatarUrl']; 
        
      } else {
        _errorMessage = "Колдонуучунун маалыматтары табылган жок.";
      }
    } catch (e) {
      _errorMessage = "Маалыматтарды жүктөөдө ката кетти: $e";
    } finally {
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
        setState(() {
          _pickedImageFile = File(pickedFile.path);
        });
      } else {
        // User canceled the picker
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Сүрөт тандоодо ката кетти: $e")),
      );
    }
  }

  Future<String?> _uploadImage(File imageFile) async {
    if (_currentUser == null) return null;
    try {
      final String fileName = 'profile_pictures/${_currentUser!.uid}/${DateTime.now().millisecondsSinceEpoch}.png';
      final Reference storageRef = _storage.ref().child(fileName);
      final UploadTask uploadTask = storageRef.putFile(imageFile);
      final TaskSnapshot snapshot = await uploadTask;
      final String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
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
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    if (_currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Колдонуучу табылган жок. Сактоо мүмкүн эмес.")),
      );
      setState(() => _isLoading = false);
      return;
    }

    try {
      String? newAvatarUrl = _avatarUrl; // Keep old URL by default
      if (_pickedImageFile != null) {
        // Upload new image if one was picked
        newAvatarUrl = await _uploadImage(_pickedImageFile!); 
        if (newAvatarUrl == null) {
          // Handle upload failure (error message is shown in _uploadImage)
          setState(() => _isLoading = false);
          return;
        }
      }

      final Map<String, dynamic> updatedData = {
        'fullName': _nameController.text.trim(),
        if (newAvatarUrl != null) 'avatarUrl': newAvatarUrl, // Add avatarUrl to updatedData
      };

      if (_dateController.text.isNotEmpty) {
        try {
          final DateFormat inputFormat = DateFormat('d MMMM, yyyy', 'ru');
          final DateTime parsedDate = inputFormat.parseLoose(_dateController.text);
          updatedData['dateOfBirth'] = Timestamp.fromDate(parsedDate);
        } catch (e) {
           ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Туулган дата форматы туура эмес: ${_dateController.text}")),
          );
          setState(() => _isLoading = false);
          return;
        }
      } else {
        updatedData['dateOfBirth'] = null;
      }

      await _firestore.collection('users').doc(_currentUser!.uid).update(updatedData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Профиль ийгиликтүү сакталды!")),
      );
      if (mounted) {
        context.pop();
      }
    } catch (e) {
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
        // Keep default initialDate if parsing fails
      }
    }

    final picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      locale: const Locale('ru', ''),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      final DateFormat formatter = DateFormat('d MMMM, yyyy', 'ru');
      _dateController.text = formatter.format(picked);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: BackButton(
          color: AppColors.primary,
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            }
          },
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
                        imageFile: _pickedImageFile, // Pass the picked image file
                        onEditPressed: _pickImage, // Call _pickImage on edit pressed
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: ValueListenableBuilder<TextEditingValue>(
                          valueListenable: _nameController,
                          builder: (context, value, child) {
                            return Text(
                              value.text.isNotEmpty ? value.text : 'Аты-жөнү',
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
                        hintText: 'кк.aaaa.жжжж',
                        readOnly: true,
                        suffixIcon: const Icon(Icons.calendar_today, color: AppColors.primary),
                        onTap: () => _selectDate(context), // Call the extracted method
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