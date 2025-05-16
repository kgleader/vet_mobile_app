import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/core/custom_button.dart';
import 'package:vet_mobile_app/core/google.dart';
import 'package:vet_mobile_app/data/firebase/auth_service.dart';
import 'package:vet_mobile_app/screens/auth/widgets/auth_fields.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart'; // Added this import

class LoginScreen extends StatefulWidget {
  const LoginScreen( {super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final AuthService _authService = AuthService();
  
  bool _isLoading = false;
  bool _isGoogleLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
  if (_formKey.currentState!.validate()) {
    setState(() => _isLoading = true);
    try {
      // TODO: Добавить логику входа через API
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) context.go('/profile'); // Переход на экран профиля
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // Changed from CrossAxisAlignment.start
              children: [
                const SizedBox(height: 24),
                _buildHeader(),
                const SizedBox(height: 30),
                _buildPhoneInput(), // Removed Align wrapper
                const SizedBox(height: 20),
                _buildPasswordInput(), // Removed Align wrapper
                const SizedBox(height: Sizes.spacingM), // Кошулду
                _buildForgotPassword(),
                const SizedBox(height: 24),
                Center(child: _buildLoginButton()), // Wrapped with Center
                const SizedBox(height: 20),
                _buildRegisterLink(),
                const SizedBox(height: 30),
                _buildDivider(),
                const SizedBox(height: Sizes.spacingM),
                _buildGoogleButton(),
                const SizedBox(height: 50),
                _buildCopyright(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.primary,
            size: 20,
          ),
          onPressed: () => context.go(RouteNames.splash),
          padding: EdgeInsets.zero,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(
              'assets/icons/common/logo.png',
              width: 100,
              height: 50,
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () => context.go(RouteNames.menu),
              child: Text(
                'Өткөрүп жиберүү',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPhoneInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: (Sizes.inputPadding * 1) + Sizes.iconSize),
          child: Text(
            'Сиздин номериңиз',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(height: 8),
        PhoneField(controller: _phoneController),
      ],
    );
  }

  Widget _buildPasswordInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: (Sizes.inputPadding * 1) + Sizes.iconSize),
          child: Text(
            'Сыр сөз',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(height: 8),
        PasswordField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          onToggleVisibility: () => setState(() => _obscurePassword = !_obscurePassword),
        ),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: () => context.go(RouteNames.forgotPassword),
        child: Text(
          'Сыр сөздү унуттуңузбу?',
          style: AppTextStyles.bodyMedium.copyWith(
            color: AppColors.primary,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return CustomButton(
      text: 'Кирүү',
      onPressed: _isLoading ? null : _login,
      isLoading: _isLoading,
    );
  }

  Widget _buildRegisterLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Аккаунтуңуз жокпу? ',
          style: AppTextStyles.bodyMedium,
        ),
        Text(
          'Ушул ',
          style: AppTextStyles.bodyMedium,
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () => context.go(RouteNames.register),
          child: Text(
            'жерден',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.primary,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        Text(
          ' катталыңыз',
          style: AppTextStyles.bodyMedium,
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'же',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }

Widget _buildGoogleButton() {
  return GoogleSignInButton(
    onPressed: signInWithGoogle,
    isLoading: _isGoogleLoading,
  );
}

Future<void> signInWithGoogle() async {
  try {
    setState(() => _isGoogleLoading = true);
    
    final userCredential = await _authService.signInWithGoogle();
    
    if (userCredential != null && mounted) {
      context.go('/profile');
    }
  } catch (e) {
    debugPrint("Error in sign in: $e");
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google аркылуу кирүүдө ката: Сураныч кайра аракет кылыңыз')),
      );
    }
  } finally {
    if (mounted) setState(() => _isGoogleLoading = false);
  }
}

  Widget _buildCopyright() {
    return Center(
      child: Text(
        '© МаралАкгул.Баардык укуктар корголгон',
        style: AppTextStyles.bodyMedium.copyWith(
          color: AppColors.textSecondary,
          fontSize: 12,
        ),
      ),
    );
  }
}