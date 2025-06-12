/**
 * Vet Message Screen
 * 
 * This screen allows users to send a message to a veterinarian along with an optional
 * image attachment. Users must provide their name, phone number and message text.
 * The form includes validation for all fields before submission to Firestore.
 */
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/data/models/vet_model.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/core/app_logo.dart';
import 'package:vet_mobile_app/screens/error/four_o_four_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VetMessage extends StatefulWidget {
  final String? vetId;
  final String? vetName;
  final VetModel? vet;

  const VetMessage({super.key, this.vetId, this.vetName, this.vet});

  @override
  State<VetMessage> createState() => _VetMessageState();
}

class _VetMessageState extends State<VetMessage> {
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  
  // Variables to handle both web and mobile platforms
  File? _imageFile;
  Uint8List? _webImage;
  bool get _hasImage => _imageFile != null || _webImage != null;
  
  bool _isLoading = false;
  bool _isPhoneValid = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_validatePhoneNumber);
  }

  @override
  void dispose() {
    _messageController.dispose();
    _nameController.dispose();
    _phoneController.removeListener(_validatePhoneNumber);
    _phoneController.dispose();
    super.dispose();
  }

  void _validatePhoneNumber() {
    final phoneText = _phoneController.text;
    final RegExp phoneRegExp = RegExp(r'^\+996\d{9}$');
    final cleanedPhone = phoneText.replaceAll(RegExp(r'[^\d+]'), '');
    
    setState(() {
      _isPhoneValid = phoneRegExp.hasMatch(cleanedPhone);
    });
  }

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Аты-жөнүңүздү киргизиңиз';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Телефон номериңизди киргизиңиз';
    }
    final RegExp phoneRegExp = RegExp(r'^\+996\d{9}$');
    final cleanedPhone = value.replaceAll(RegExp(r'[^\d+]'), '');
    if (!phoneRegExp.hasMatch(cleanedPhone)) {
      return 'Номериңизди туура форматта киргизиңиз (+996XXXXXXXXX)';
    }
    return null;
  }

  String? _validateMessage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Билдирүүңүздүн текстин киргизиңиз';
    }
    return null;
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        if (kIsWeb) {
          // Handle web platform
          image.readAsBytes().then((value) {
            setState(() {
              _webImage = value;
              _imageFile = null;
            });
          });
        } else {
          // Handle mobile platforms
          _imageFile = File(image.path);
          _webImage = null;
        }
      });
    }
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _sendMessage() async {
    if (!_formKey.currentState!.validate()) {
      _showSnackbar(context, 'Сураныч, бардык талааларды туура толтуруңуз');
      return;
    }
    setState(() => _isLoading = true);

    try {
      await FirebaseFirestore.instance.collection('messages').add({
        'vetId': widget.vetId,
        'name': _nameController.text,
        'phone': _phoneController.text,
        'message': _messageController.text,
        'createdAt': FieldValue.serverTimestamp(),
      });

      await Future.delayed(const Duration(seconds: 1));

      if (mounted) {
        setState(() => _isLoading = false);
        GoRouter.of(context).pushReplacementNamed(RouteNames.vetMessageSuccess); 
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        print("Error in _sendMessage: $e"); 
        GoRouter.of(context).pushNamed(
          RouteNames.vetMessageFailure, 
          extra: FourOFourScreen(
            title: 'Ката кетти!',
            message: 'Билдирүү жөнөтүүдө ката кетти. Сураныч, кайра аракет кылыңыз.\nДеталдар: ${e.toString()}',
            buttonText: 'Кайра аракет',
            onButtonPressed: () {
              if (GoRouter.of(context).canPop()) {
                GoRouter.of(context).pop();
              }
            },
          )
        );
      }
    }
  }

  // Cross-platform image display method
  Widget _buildImageWidget() {
    if (kIsWeb && _webImage != null) {
      // Display image in web mode
      return Image.memory(
        _webImage!,
        height: 150,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else if (!kIsWeb && _imageFile != null) {
      // Display image on mobile platforms
      return Image.file(
        _imageFile!,
        height: 150,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else {
      // Fallback for any platform if there are issues
      return Container(
        height: 150,
        width: double.infinity,
        color: Colors.grey.shade200,
        alignment: Alignment.center,
        child: const Text(
          'Image preview not available',
          style: TextStyle(color: AppColors.primary),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Ветеринар',
          style: AppTextStyles.heading2.copyWith(color: AppColors.textPrimary),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
              },
              child: const AppLogo(),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView( 
          padding: const EdgeInsets.all(16),
          children: [ 
            Text(
              'Ветеринарга билдирүү таштоо',
              style: AppTextStyles.heading3.copyWith(fontWeight: FontWeight.bold), 
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),

            TextFormField( 
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'Аты жөнү',
                prefixIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Icon(Icons.person_outline, color: Colors.grey),
                ),
                border: OutlineInputBorder( 
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ), 
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                filled: true,
                fillColor: Colors.grey.shade50, 
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
              validator: _validateName, 
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: 16),
            
            TextFormField( 
              controller: _phoneController,
              decoration: InputDecoration(
                hintText: '+996 XXX XXX XXX',
                prefixIcon: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Icon(Icons.phone_outlined, color: Colors.grey),
                ),
                suffixIcon: _phoneController.text.isEmpty 
                    ? null 
                    : (_isPhoneValid 
                        ? const Icon(Icons.check_circle, color: Colors.green) 
                        : const Icon(Icons.error_outline, color: Colors.red)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
                contentPadding: const EdgeInsets.symmetric(vertical: 15),
              ),
              keyboardType: TextInputType.phone,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
                LengthLimitingTextInputFormatter(13),
              ],
              validator: _validatePhone,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: 24), 

            TextFormField( 
              controller: _messageController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Текст',
                prefixIcon: const Padding(
                  padding: EdgeInsets.only(left: 15, top: 15), 
                  child: Icon(Icons.edit_outlined, color: Colors.grey),
                ),
                border: OutlineInputBorder( 
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                filled: true,
                fillColor: Colors.grey.shade50, 
                contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              ),
              validator: _validateMessage,
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            const SizedBox(height: 24),
            
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: _pickImage,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.photo_camera_outlined, size: 24, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text('Сүрөт жүктөө', style: AppTextStyles.body),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _showSnackbar(context, '"Баасы" функциясы азырынча иштебейт');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.attach_file_outlined, size: 24, color: Colors.grey),
                          const SizedBox(width: 8),
                          Text('Баасы', style: AppTextStyles.body),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            if (_imageFile != null || _webImage != null) 
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _buildImageWidget(),
                ),
              ),
              const SizedBox(height: 32),
              
              ElevatedButton(
                onPressed: _isLoading ? null : _sendMessage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50), 
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24), 
                  ),
                  textStyle: AppTextStyles.buttonText.copyWith(fontWeight: FontWeight.bold),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : const Text("Жиберүү"),
              ),
              const SizedBox(height: 16), 
              const SizedBox(height: 100), 
          ],
        ),
      ),
    );
  }
}