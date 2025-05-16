import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vet_mobile_app/core/app_colors.dart';

class GoogleSignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool isLoading;

  const GoogleSignInButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Center( 
      child: InkWell(
        onTap: isLoading ? null : onPressed,
        customBorder: const CircleBorder(), 
        child: Padding(
          padding: const EdgeInsets.all(25.0), 
          child: isLoading
              ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary,
                  ),
                )
              : SvgPicture.asset(
                  'assets/icons/common/google_button.svg', 
                  width: 40, 
                  height: 40, 
                ),
        ),
      ),
    );
  }
}