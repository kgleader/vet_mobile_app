import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';

class VetMessageFailureScreen extends StatelessWidget {
  final Exception? error; // GoRouter'дан катаны алуу үчүн (милдеттүү эмес)
  final String? title;
  final String? message;
  final String? buttonText;
  final VoidCallback? onRetry; // "Try Again" үчүн атайын аракет

  const VetMessageFailureScreen({
    super.key,
    this.error,
    this.title,
    this.message,
    this.buttonText,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    // GoRouter'дан келген катаны же берилген билдирүүнү колдонуу
    final displayTitle = title ?? 'Sorry!';
    final displayMessage = message ??
        (error != null
            ? "An unexpected error occurred: ${error.toString()}" // GoRouter катасын көрсөтүү
            : "The page you are looking for doesn't exist or another error occurred.");
    final displayButtonText = buttonText ?? (onRetry != null ? 'Try Again' : 'Go back');

    // Дебаг үчүн катаны консолго чыгаруу
    if (error != null) {
      print("Error displayed on VetMessageFailureScreen: $error");
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () {
            if (GoRouter.of(context).canPop()) {
              GoRouter.of(context).pop();
            } else {
              GoRouter.of(context).go(RouteNames.menu);
            }
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Бул жерге Figma'дагыдай 404 графикасын же ката иконкасын кошсоңуз болот
              // Мисалы, эгер бул 404 катасы болсо, 404 графикасы, башка ката болсо, башка иконка.
              // Азырынча жалпы ката иконкасы:
              const Icon(
                Icons.error_outline_rounded,
                color: AppColors.primary, // Же катанын түрүнө жараша түс
                size: 80,
              ),
              const SizedBox(height: 32),
              Text(
                displayTitle,
                style: AppTextStyles.heading1.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                displayMessage,
                style: AppTextStyles.body.copyWith(fontSize: 16, color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: onRetry ??
                    () {
                      if (GoRouter.of(context).canPop()) {
                        GoRouter.of(context).pop();
                      } else {
                        GoRouter.of(context).go(RouteNames.menu);
                      }
                    },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.textPrimary, // Figma'дагыдай кара түс
                  foregroundColor: Colors.white,
                  minimumSize: const Size(200, 50),
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: AppTextStyles.buttonText.copyWith(fontWeight: FontWeight.bold),
                ),
                child: Text(displayButtonText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
