import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_logo.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/core/app_strings.dart';
import 'package:vet_mobile_app/widgets/custom_bottom_sheet.dart';
import 'package:vet_mobile_app/core/bottom_bar.dart';

class AboutUsScreen extends StatelessWidget {
  final String title;

  const AboutUsScreen({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => context.go(RouteNames.menu), // Өзгөртүлдү
        ),
        title: Text(
          title, // Бул жерде "Биз жөнүндө" деген аталыш келет
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
            const SizedBox(height: Sizes.spacingL), // AppBar'дан кийинки боштук
            Center(
              child: Text(
                "Тема", // Сүрөттөгүдөй "Тема" тексти
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: Sizes.spacingL), // "Тема" текстинен кийинки боштук
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingS),
              child: Text(
                AppStrings.aboutUsBodyText, // Сиздин негизги текстиңиз
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
                textAlign: TextAlign.start,
              ),
            ),
            const SizedBox(height: Sizes.spacingL), // Added space before the button
            ElevatedButton( // ADDED: Button to trigger the bottom sheet
              onPressed: () {
                showCustomBottomSheet(
                  context,
                  title: "About Our App", // Example Title
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("This app helps veterinarians manage their daily tasks."),
                      SizedBox(height: 8),
                      Text("Version: 1.0.0"),
                      // Add more widgets as needed
                    ],
                  ),
                );
              },
              child: const Text("Show More Info"),
            ),
            const SizedBox(height: Sizes.paddingL), // Added space after the button
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(currentIndex: 1), // ADDED: BottomBar, assuming 'Menu' is index 1
    );
  }
}