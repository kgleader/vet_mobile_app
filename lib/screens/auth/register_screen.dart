/**
 * Registration Screen
 * 
 * This screen handles user registration with email/password and Google Sign-In.
 * It includes form validation for all fields including name, phone, email,
 * and password with confirmation. Successful registration navigates to the menu screen.
 */
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/core/custom_button.dart';
import 'package:vet_mobile_app/core/google.dart';
import 'package:vet_mobile_app/data/firebase/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  bool _isGoogleLoading = false;
  final AuthService _authService = AuthService();

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose(); // Кошулду
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _signInWithGoogle() async {
    setState(() => _isGoogleLoading = true);
    try {
      final UserCredential? userCredential = await _authService.signInWithGoogle();
      if (userCredential != null && mounted) {
        // Navigate to a different screen or show success message
        context.go(RouteNames.menu); // Example: Navigate to menu
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Google менен кирүүдө ката: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isGoogleLoading = false);
      }
    }
  }

  void _togglePasswordVisibility() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
  }

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      try {
        final UserCredential? userCredential = await _authService.signUpWithEmailPasswordAndSaveData(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          fullName: _fullNameController.text.trim(),
          phoneNumber: _phoneController.text.trim(),
        );

        if (userCredential != null && mounted) {
          context.go(RouteNames.menu);
        }
      } on FirebaseAuthException catch (e) {
        if (mounted) {
          String errorMessage = 'Каттоодо ката кетти.';
          if (e.code == 'email-already-in-use') {
            errorMessage = 'Бул электрондук почта мурунтан эле катталган.';
          } else if (e.code == 'weak-password') {
            errorMessage = 'Сыр сөз өтө жөнөкөй.';
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage)),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Каттоодо белгисиз ката кетти: $e')),
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
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.primary),
        onPressed: () => context.go(RouteNames.login),
      ),
      centerTitle: false, // Ensure title is not centered to allow actions to align right
      title: null, // Remove the title
      toolbarHeight: 80.0, // Increased AppBar height
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: Sizes.paddingM), // Add some padding to the right
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center items vertically in the column
            crossAxisAlignment: CrossAxisAlignment.end, // Align items to the end (right) of the column
            children: [
              Image.asset(
                'assets/icons/common/logo.png', // Assuming this is the correct path
                height: 50,
                width: 90, // Optional: specify width if needed
              ),
              const SizedBox(height: Sizes.spacingS), // Keep spacingS, adjust if needed after testing toolbarHeight
              TextButton(
                onPressed: () => context.go(RouteNames.menu),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero, // Remove default padding
                  minimumSize: Size.zero, // Remove minimum size constraint
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduce tap target size
                ),
                child: Text(
                  'Өткөрүп жиберүү',
                  style: AppTextStyles.bodySmall.copyWith( // Adjusted style for better fit
                    color: AppColors.primary,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
      elevation: 0,
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.paddingL,
        vertical: Sizes.paddingXL,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInputField(
              label: 'Толук аты жөнү',
              controller: _fullNameController,
              hintText: 'Асан Асанов',
              prefixIcon: Icons.person_outline,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Толук атыңызды киргизиңиз';
                }
                return null;
              },
            ),
            const SizedBox(height: Sizes.spacingS),
            _buildInputField(
              label: 'Телефон номери',
              controller: _phoneController,
              hintText: '996700700700',
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Телефон номериңизди киргизиңиз';
                }
                return null;
              },
            ),
            const SizedBox(height: Sizes.spacingS),
            _buildInputField(
              label: 'Электрондук почта',
              controller: _emailController,
              hintText: 'email@example.com',
              prefixIcon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Электрондук почтаңызды киргизиңиз';
                }
                if (!value!.contains('@') || !value.contains('.')) {
                  return 'Туура электрондук почта дарегин киргизиңиз';
                }
                return null;
              },
            ),
            const SizedBox(height: Sizes.spacingS),
            _buildInputField(
              label: 'Сыр сөз',
              controller: _passwordController,
              hintText: '••••••••',
              prefixIcon: Icons.lock_outline,
              obscureText: _obscurePassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.textSecondary,
                ),
                onPressed: _togglePasswordVisibility,
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Сыр сөзүңүздү киргизиңиз';
                }
                if (value!.length < 6) {
                  return 'Сыр сөз 6 символдон кем болбошу керек';
                }
                return null;
              },
            ),
            const SizedBox(height: Sizes.spacingS),
            _buildInputField(
              label: 'Сыр сөздү ырастоо',
              controller: _confirmPasswordController,
              hintText: '••••••••',
              prefixIcon: Icons.lock_outline,
              obscureText: _obscureConfirmPassword,
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.textSecondary,
                ),
                onPressed: _toggleConfirmPasswordVisibility,
              ),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Сыр сөздү ырастаңыз';
                }
                if (value != _passwordController.text) {
                  return 'Сыр сөздөр дал келбейт';
                }
                return null;
              },
            ),
            const SizedBox(height: Sizes.spacingS),
            Center( // Added Center widget
              child: CustomButton(
                text: 'Катталуу',
                onPressed: _isLoading ? null : () => _register(),
                isLoading: _isLoading,
              ),
            ),
            const SizedBox(height: Sizes.spacingM), // Added some space before the new text
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                  children: <TextSpan>[
                    const TextSpan(text: 'Катталган акаунтунуз барбы? '),
                    TextSpan(
                      text: 'Бул жерден',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.go(RouteNames.login);
                        },
                    ),
                    const TextSpan(text: ' кириниз.'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: Sizes.spacingS),
            _buildDivider(),
            const SizedBox(height: Sizes.spacingS),
            _buildGoogleButton(),
            const SizedBox(height: Sizes.spacingS),
            _buildCopyright(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: SizedBox(
            width: Sizes.inputWidth,
            child: Text(
              label,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
          ),
        ),
        const SizedBox(height: Sizes.spacingS),
        Center(
          child: SizedBox(
            width: Sizes.inputWidth,
            height: Sizes.inputHeight,
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              style: AppTextStyles.inputText,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppTextStyles.inputHint,
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.inputPadding,
                  ),
                  child: Icon(
                    prefixIcon,
                    color: AppColors.primary,
                    size: Sizes.iconSize,
                  ),
                ),
                suffixIcon:
                    suffixIcon != null
                        ? Padding(
                          padding: const EdgeInsets.only(
                            right: Sizes.inputPadding,
                          ),
                          child: suffixIcon,
                        )
                        : null,
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
              validator: validator,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingM),
          child: Text(
            'Же',
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
      onPressed: _signInWithGoogle,
      isLoading: _isGoogleLoading,
    );
  }

  Widget _buildCopyright() {
    return Center(
      child: Text(
        '© МаралАкгул. Баардык укуктар корголгон',
        style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
      ),
    );
  }
}
