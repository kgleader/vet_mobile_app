import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/core/custom_button.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        // TODO: Добавить логику сброса пароля
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          context.go(RouteNames.login); // После сброса пароля перенаправляем на логин
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: _buildResetPasswordForm(),
        ),
      ),
    );
  }
  
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: AppColors.primary,
          size: Sizes.iconSize,
        ),
        onPressed: () => context.go(RouteNames.login),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: Sizes.padding),
          child: InkWell(
            onTap: () => context.go(RouteNames.profile),
            child: Image.asset(
              'assets/icons/common/logo.png',
              width: Sizes.logoWidth,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResetPasswordForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Text(
            'Сураныч жаңы код жазыңыз',
            style: AppTextStyles.heading2,
          ),
          const SizedBox(height: 5),
          const SizedBox(height: 24),
          _buildPasswordField(),
          const SizedBox(height: 16),
          _buildConfirmPasswordField(),
          const SizedBox(height: 32),
          CustomButton(
            text: 'Сырсөздү жаңыртуу',            
            isLoading: _isLoading,
            onPressed: _resetPassword,
          ),
          const SizedBox(height: 300),
          Center(
            child: Text(
              '© МаралАкгул.Баардык укуктар корголгон',
              style: AppTextStyles.captionText.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildPasswordField() {
    return TextFormField(
      controller: _newPasswordController,
      obscureText: _obscurePassword,
      style: AppTextStyles.inputText,
      decoration: InputDecoration(
        hintText: 'Жаңы сырсөз',
        hintStyle: AppTextStyles.inputHint,
        prefixIcon: const Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.inputPadding),
          child: Icon(
            Icons.lock_outline,
            color: AppColors.primary,
            size: Sizes.iconSize,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: AppColors.primary,
            size: Sizes.iconSize,
          ),
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.inputRadius),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: Sizes.borderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.inputRadius),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: Sizes.borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.inputRadius),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: Sizes.borderWidth,
          ),
        ),
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: Sizes.inputPadding,
          horizontal: Sizes.inputPadding,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Сырсөздү киргизиңиз';
        }
        if (value.length < 6) {
          return 'Сырсөз 6 символдон көп болушу керек';
        }
        return null;
      },
    );
  }
  
  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: _obscureConfirmPassword,
      style: AppTextStyles.inputText,
      decoration: InputDecoration(
        hintText: 'Жаңы сырсөздү кайталаңыз',
        hintStyle: AppTextStyles.inputHint,
        prefixIcon: const Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.inputPadding),
          child: Icon(
            Icons.lock_outline,
            color: AppColors.primary,
            size: Sizes.iconSize,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
            color: AppColors.primary,
            size: Sizes.iconSize,
          ),
          onPressed: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.inputRadius),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: Sizes.borderWidth,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.inputRadius),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: Sizes.borderWidth,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.inputRadius),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: Sizes.borderWidth,
          ),
        ),
        fillColor: Colors.white,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(
          vertical: Sizes.inputPadding,
          horizontal: Sizes.inputPadding,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Сырсөздү кайталаңыз';
        }
        if (value != _newPasswordController.text) {
          return 'Сырсөздөр дал келбейт';
        }
        return null;
      },
    );
  }
}