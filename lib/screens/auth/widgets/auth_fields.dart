// Бул файл аутентификация формаларында колдонулуучу текст киргизүү талааларын (телефон, сыр сөз, email, сыр сөздү ырастоо) аныктайт.
import 'package:flutter/material.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/widgets/common/custom_text_field.dart';

class PhoneField extends StatelessWidget {
  final TextEditingController controller;

  const PhoneField({
    super.key, 
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: '996700700700',
      prefixIcon: Icons.phone_outlined,
      keyboardType: TextInputType.phone,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Телефон номериңизди киргизиңиз';
        }
        return null;
      },
    );
  }
}

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;

  const PasswordField({
    super.key,
    required this.controller,
    this.hintText = '••••••••',
    this.obscureText = true,
    this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: hintText,
      prefixIcon: Icons.lock_outline,
      obscureText: obscureText,
      suffixIcon: IconButton(
        icon: Icon(
          obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: AppColors.primary,
          size: Sizes.iconSize,
        ),
        onPressed: onToggleVisibility,
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Сыр сөзүңүздү киргизиңиз';
        }
        if (value!.length < 6) {
          return 'Сыр сөз жок дегенде 6 символдон турушу керек';
        }
        return null;
      },
    );
  }
}

class EmailField extends StatelessWidget {
  final TextEditingController controller;

  const EmailField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: 'example@mail.com',
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
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

class ConfirmPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final TextEditingController passwordController;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;

  const ConfirmPasswordField({
    super.key,
    required this.controller,
    required this.passwordController,
    this.obscureText = true,
    this.onToggleVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: '••••••••',
      prefixIcon: Icons.lock_outline,
      obscureText: obscureText,
      suffixIcon: IconButton(
        icon: Icon(
          obscureText ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          color: AppColors.primary,
          size: Sizes.iconSize,
        ),
        onPressed: onToggleVisibility,
      ),
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return 'Сыр сөздү кайталап киргизиңиз';
        }
        if (value != passwordController.text) {
          return 'Сыр сөздөр дал келбейт';
        }
        return null;
      },
    );
  }
}