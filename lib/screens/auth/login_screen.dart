/**
 * Login Screen
 * 
 * This screen handles user authentication with email/password and Google Sign-In.
 * It provides form validation, login functionality, password reset navigation,
 * and navigation to registration screen for new users.
 */
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
import 'package:vet_mobile_app/config/constants/sizes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen( {super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final AuthService _authService = AuthService();
  
  bool _isLoading = false;
  bool _isGoogleLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose(); // _phoneController ордуна
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final userCredential = await _authService.signInWithEmailPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        if (userCredential != null && mounted) {
          // Ийгиликтүү киргенден кийин профиль экранына өтүү
          context.go(RouteNames.profile); 
        } else {
          // Бул учур сейрек кездешет, анткени ката болсо exception ыргытылат
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Кирүүдө белгисиз ката кетти.')),
            );
          }
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'Кирүүдө ката кетти.';
        if (e.code == 'user-not-found') {
          errorMessage = 'Мындай колдонуучу табылган жок.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Сыр сөз туура эмес.';
        } else if (e.code == 'invalid-email') {
          errorMessage = 'Электрондук почта форматы туура эмес.';
        }
        // Башка ката коддорун да ушул жерден кармасаңыз болот, мис., 'too-many-requests'
        debugPrint("LoginScreen: FirebaseAuthException: ${e.code} - ${e.message}");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        }
      } catch (e) {
        debugPrint("LoginScreen: Жалпы ката: $e");
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Күтүлбөгөн ката кетти. Кайра аракет кылыңыз.')),
          );
        }
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
              crossAxisAlignment: CrossAxisAlignment.stretch, 
              children: [
                const SizedBox(height: 24),
                _buildHeader(),
                const SizedBox(height: 30),
                _buildEmailInput(), // _buildPhoneInput ордуна
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

  Widget _buildEmailInput() { // _buildPhoneInput ордуна _buildEmailInput
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: (Sizes.inputPadding * 1) + Sizes.iconSize),
          child: Text(
            'Электрондук почта', // "Сиздин номериңиз" ордуна
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(height: 8),
        EmailField(controller: _emailController), // PhoneField ордуна EmailField
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