// Бул файл жалпы колдонулуучу, кайра колдонууга ыңгайлуу текст киргизүү талаасынын (CustomTextField) виджетин аныктайт.
import 'package:flutter/material.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final bool readOnly;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: Sizes.inputWidth,
        height: Sizes.inputHeight,
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: AppTextStyles.inputText,
          readOnly: readOnly,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppTextStyles.inputHint,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.inputPadding),
              child: Icon(
                prefixIcon,
                color: AppColors.primary,
                size: Sizes.iconSize,
              ),
            ),
            suffixIcon: suffixIcon != null
                ? Padding(
                    padding: const EdgeInsets.only(right: Sizes.inputPadding),
                    child: suffixIcon,
                  )
                : null,
            border: _buildBorder(),
            enabledBorder: _buildBorder(),
            focusedBorder: _buildBorder(),
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
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(Sizes.inputRadius),
      borderSide: const BorderSide(
        color: AppColors.primary,
        width: Sizes.borderWidth,
      ),
    );
  }
}