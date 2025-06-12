/**
 * Forgot Password Screen
 * 
 * This screen provides password reset functionality by sending a password reset email.
 * Users enter their email address and submit the form, which triggers the Firebase
 * password reset flow. Success and error messages are displayed as SnackBars.
 */
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/core/custom_button.dart';
import 'package:vet_mobile_app/data/firebase/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        await _authService.sendPasswordResetEmail(email: _emailController.text.trim());
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Электрондук почтаңызга сыр сөздү калыбына келтирүү боюнча нускамалар жөнөтүлдү. Сураныч, почтаңызды текшерип, ал жактагы шилтеме аркылуу сыр сөзүңүздү алмаштырыңыз.',
                style: TextStyle(fontSize: 15),
              ),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 7),
            ),
          );
          // SnackBar көрсөтүлүп бүткөндөн кийин кирүү экранына өтүү
          await Future.delayed(const Duration(seconds: 7));
          if (mounted) {
            context.go(RouteNames.login);
          }
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage = 'Кат жөнөтүүдө ката кетти. Кайра аракет кылыңыз.';
        // 'user-not-found' шарты sendPasswordResetEmail үчүн иштебейт.
        if (e.code == 'invalid-email') {
          errorMessage = 'Электрондук почта форматы туура эмес.';
        } else if (e.code == 'too-many-requests') {
          errorMessage = 'Өтө көп аракет жасалды. Бир аздан кийин кайра аракет кылыңыз.';
        }
        // Башка FirebaseAuthException коддорун да ушул жерден кармаса болот
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Күтүлбөгөн ката кетти: $e'), backgroundColor: Colors.red),
          );
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
          child: _buildResetForm(),
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
            // Профильге өтүү бул жерде мааниге ээ эмес, анткени колдонуучу кире элек
            // onTap: () => context.go(RouteNames.profile), 
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
            // 'Сураныч, катталган электрондук дарегинизди же телефон номеринизди киргизиңиз',
            'Сыр сөздү калыбына келтирүү үчүн катталган электрондук дарегиңизди киргизиңиз. Биз сизге сыр сөздү алмаштыруу боюнча нускамаларды жөнөтөбүз.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
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
}