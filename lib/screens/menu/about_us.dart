import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_logo.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/core/app_strings.dart'; 

class AboutUsScreen extends StatelessWidget {
  final String title;
  final String iconPath;

  const AboutUsScreen({
    super.key,
    required this.title,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: Sizes.paddingL),
            child: AppLogo(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: Sizes.spacingL),
            Center(
              child: Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/icons/menu/$iconPath',
                    width: 40,
                    height: 40,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: Sizes.spacingS),
            Center(
              child: Text(
                "Тема",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: Sizes.spacingL),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingS),
              child: Text(
                AppStrings.aboutUsBodyText, // Өзгөртүлдү
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}