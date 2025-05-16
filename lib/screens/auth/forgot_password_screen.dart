import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/core/custom_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  bool _isLoading = false;
  bool _emailSent = false;

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        // TODO: Добавить логику сброса пароля
        await Future.delayed(const Duration(seconds: 2));
        if (mounted) {
          setState(() => _emailSent = true);
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  Future<void> _verifyCode() async {
    setState(() => _isLoading = true);
    try {
      // TODO: Добавить проверку кода через API
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        context.go(RouteNames.resetPassword); // Перенаправляем на экран смены пароля
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
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
          child: _emailSent ? _buildVerificationCodeScreen() : _buildResetForm(),
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

  Widget _buildResetForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 100),
          Text(
            'Сураныч, катталган электрондук дарегинизди же телефон номеринизди киргизиңиз',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 32),
          _buildEmailField(),
          const SizedBox(height: 42),
          Center(
            child: SizedBox(
              width: Sizes.buttonWidth,
              child: CustomButton(
                text: 'Жөнөтүү',
                isLoading: _isLoading,
                onPressed: _resetPassword,
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: AppTextStyles.inputText,
      decoration: InputDecoration(
        hintText: 'Электрондук почта',
        hintStyle: AppTextStyles.inputHint,
        prefixIcon: const Padding(
          padding: EdgeInsets.symmetric(horizontal: Sizes.inputPadding),
          child: Icon(
            Icons.email_outlined,
            color: AppColors.primary,
            size: Sizes.iconSize,
          ),
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
        if (value?.isEmpty ?? true) {
          return 'Электрондук почтаңызды киргизиңиз';
        }
        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
          return 'Туура электрондук почтаны киргизиңиз';
        }
        return null;
      },
    );
  }
  
  Widget _buildVerificationCodeScreen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 100),
        Text(
          'Биз озгортуу кодун жибердик',
          style: AppTextStyles.heading2,
        ),
        const SizedBox(height: 20),
        Text(
          'Сиздин киргизген электрондук почтаңыз же телефон номериңизге активдештирүү жиберилди.',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 32),
        _buildVerificationCodeInput(),
        const SizedBox(height: 40),
        CustomButton(
          text: 'Аткарылды',
          isLoading: _isLoading,
          onPressed: _verifyCode,
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
    );
  }
  
  Widget _buildVerificationCodeInput() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        6,
        (index) => SizedBox(
          width: 40,
          height: 48,
          child: TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            decoration: InputDecoration(
              counterText: '',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.primary, width: 2),
              ),
            ),
            onChanged: (value) {
              if (value.isNotEmpty && index < 5) {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
        ),
      ),
    );
  }
}