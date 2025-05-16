import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/core/app_colors.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  
  const AppBackButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: AppColors.primary,
        size: Sizes.iconSize,
      ),
      onPressed: onPressed ?? () => context.pop(),
    );
  }
}