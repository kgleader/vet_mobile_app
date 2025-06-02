import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_logo.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';

class VetMessageSuccessScreen extends StatelessWidget {
  const VetMessageSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () {
            GoRouter.of(context).go(RouteNames.menu); 
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                GoRouter.of(context).go(RouteNames.profile);
              },
              child: const AppLogo(),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true, 
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0), 
        child: Center(
          child: Text(
            'Бизге билдирүү таштаганыңыз үчүн чоң рахмат. Ветеринар суроолоруңузга жакынкы убакытта жооп берет. Күтө туруңуз.',
            style: AppTextStyles.body.copyWith(fontSize: 16), 
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
