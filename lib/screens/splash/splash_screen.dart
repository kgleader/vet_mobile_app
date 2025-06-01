import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/core/app_strings.dart';
import 'package:vet_mobile_app/core/custom_button.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Волнистый фон
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomPaint(
              painter: _SplashScreenPainter(),
              size: Size(width, height * 0.6),
            ),
          ),
          // Картинка коровы (большая, выходит за фон)
          Positioned(
            bottom: 0,
            left: 0,
            right: -width * 0.1,
            child: SizedBox(
              width: width * 0.7,
              child: Image.asset(
                'assets/images/cow.png',
                width: width * 0.7,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: height * 0.05),
                SizedBox(height: height * 0.04),
                // Кош келдиңиз текст
                Center(
                  child: Text(
                    AppStrings.splashWelcome,
                    style: AppTextStyles.heading1.copyWith(
                      color: AppColors.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: height * 0.02),
                // Описание
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: Text(
                    AppStrings.splashDescription,
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                // Заменяем Spacer на SizedBox
                SizedBox(height: height * 0.04),
                // Баштоо кнопкасы
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Sizes.paddingXL),
                  child: CustomButton(
                    text: 'Баштоо',
                    onPressed: () => context.go(RouteNames.login),
                    type: ButtonType.primary, // Указываем тип кнопки
                    isLoading: false,
                  ),
                ),

                SizedBox(height: height * 0.09),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Волнистый фон
class _SplashScreenPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = AppColors.primary
          ..style = PaintingStyle.fill;

    final path =
        Path()
          ..moveTo(0, size.height * 0.7)
          ..quadraticBezierTo(
            size.width * 0.5,
            size.height * 1.05,
            size.width,
            size.height * 0.7,
          )
          ..lineTo(size.width, size.height)
          ..lineTo(0, size.height)
          ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
