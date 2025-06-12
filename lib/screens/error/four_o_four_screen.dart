import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';

class FourOFourScreen extends StatelessWidget {
  final Exception? error;
  final String? title;
  final String? message;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const FourOFourScreen({
    super.key,
    this.error,
    this.title,
    this.message,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    final displayTitle = title ?? 'Sorry!';
    final displayMessage = message ??
        (error != null
            // GoRouter'дан келген катаны көрсөтүү (мисалы, 404 үчүн)
            ? "The page you are looking for at '${GoRouterState.of(context).uri.toString()}' doesn't exist or another error occurred.\nDetails: ${error.toString()}"
            : "Something went wrong. Please try again later.");
    final displayButtonText = buttonText ?? 'Go back';

    // Дебаг үчүн катаны консолго чыгаруу
    if (error != null) {
      print("Error displayed on FourOFourScreen: $error. URI: ${GoRouterState.of(context).uri.toString()}");
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
              const Icon(
                Icons.error_outline_rounded,
                color: AppColors.primary,
                size: 100,
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
                onPressed: onButtonPressed ?? // Эгер onButtonPressed берилсе, ошону аткарат
                    () {
                  if (GoRouter.of(context).canPop()) {
                    GoRouter.of(context).pop();
                  } else {
                    GoRouter.of(context).go(RouteNames.menu);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.textPrimary,
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
