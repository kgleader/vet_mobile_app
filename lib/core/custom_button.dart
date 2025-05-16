import 'package:flutter/material.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';

enum ButtonType { primary, secondary, outline, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final ButtonType type;
  final double? width;
  final double? height;
  final EdgeInsets? padding;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.type = ButtonType.primary,
    this.width,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ButtonType.primary:
        return _buildPrimaryButton();
      case ButtonType.secondary:
        return _buildSecondaryButton();
      case ButtonType.outline:
        return _buildOutlineButton();
      case ButtonType.text:
        return _buildTextButton();
    }
  }

  Widget _buildPrimaryButton() {
    return SizedBox(
      width: width ?? Sizes.buttonWidth,
      height: height ?? Sizes.buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.buttonRadius),
          ),
          padding: padding ?? const EdgeInsets.symmetric(vertical: Sizes.buttonPadding),
          elevation: 0,
          disabledBackgroundColor: AppColors.primary.withOpacity(0.6),
        ),
        child: _buildChild(Colors.white),
      ),
    );
  }

  Widget _buildSecondaryButton() {
    return SizedBox(
      width: width ?? Sizes.buttonWidth,
      height: height ?? Sizes.buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.background,
          foregroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.buttonRadius),
          ),
          padding: padding ?? const EdgeInsets.symmetric(vertical: Sizes.buttonPadding),
          elevation: 0,
          disabledBackgroundColor: AppColors.background.withOpacity(0.6),
        ),
        child: _buildChild(AppColors.primary),
      ),
    );
  }

  Widget _buildOutlineButton() {
    return SizedBox(
      width: width ?? Sizes.buttonWidth,
      height: height ?? Sizes.buttonHeight,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(
            color: AppColors.primary,
            width: Sizes.borderWidth,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Sizes.buttonRadius),
          ),
          padding: padding ?? const EdgeInsets.symmetric(vertical: Sizes.buttonPadding),
        ),
        child: _buildChild(AppColors.primary),
      ),
    );
  }

  Widget _buildTextButton() {
    return TextButton(
      onPressed: isLoading ? null : onPressed,
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        padding: padding ?? EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        text,
        style: AppTextStyles.linkText.copyWith(
          color: AppColors.primary,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Widget _buildChild(Color color) {
    if (isLoading) {
      return SizedBox(
        height: Sizes.loaderSize,
        width: Sizes.loaderSize,
        child: CircularProgressIndicator(
          color: color,
          strokeWidth: Sizes.borderWidth,
        ),
      );
    }
    return Text(
      text,
      style: AppTextStyles.buttonText.copyWith(color: color),
      textAlign: TextAlign.center,
    );
  }
}