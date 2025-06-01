import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_logo.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/config/router/route_names.dart'; // Эгер негизги бетке кайтуу үчүн керек болсо

class VetMessageSuccessScreen extends StatelessWidget {
  const VetMessageSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Figma'да AppBar'дын аталышы жок, бирок артка жебеси жана лого бар.
    // Артка жебеси басылганда, кайсы экранга кайтыш керек экенин чечиш керек.
    // Мисалы, ветеринарлардын тизмесине же башкы бетке.
    // Азырынча, мурунку экранга (vet_message) кайтабыз.
    // Же болбосо, түздөн-түз негизги менюга: GoRouter.of(context).go(RouteNames.menu);
    
    // Автоматтык түрдө бир нече секунддан кийин кайтуу үчүн:
    // Future.delayed(const Duration(seconds: 3), () {
    //   if (context.mounted) {
    //     // Мисалы, ветеринарлар тизмесине же негизги бетке кайтуу
    //     // GoRouter.of(context).go(RouteNames.vetList); // vetList маршрутуңузга жараша
    //     // Же жөн эле мурунку эки экранды жабуу (бул экранды жана vet_message экранын)
    //     GoRouter.of(context).pop(); // Бул экранды жабуу
    //     if (GoRouter.of(context).canPop()) {
    //        GoRouter.of(context).pop(); // vet_message экранын жабуу
    //     }
    //   }
    // });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () {
            // Бул экранды жаап, vet_message экранына кайтат.
            // Эгер vet_message экранын да жаап, андан мурункуга (мис., veterinar_screen)
            // кайткыңыз келсе, анда GoRouter менен башкача навигация кылуу керек.
            // Мисалы, бул экранга келгенде vet_message экранын алмаштырып (replace) келсе,
            // анда pop() туура иштейт.
            // Же болбосо, негизги бетке өтүү:
            GoRouter.of(context).go(RouteNames.menu); // Мисал катары негизги меню
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
        centerTitle: true, // Figma'да аталыш жок болгондуктан, бул маанилүү эмес
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0), // Четтеринен көбүрөөк боштук
        child: Center(
          child: Text(
            'Бизге билдирүү таштаганыңыз үчүн чоң рахмат. Ветеринар суроолоруңузга жакынкы убакытта жооп берет. Күтө туруңуз.',
            style: AppTextStyles.body.copyWith(fontSize: 16), // Тексттин өлчөмүн бир аз чоңойтуу
            textAlign: TextAlign.center,
          ),
        ),
      ),
      // Эгер бул экран ShellRoute'тун бир бөлүгү болсо, BottomNavigationBar автоматтык түрдө көрүнөт.
      // Эгер өзүнчө push кылынса, анда BottomNavigationBar бул жерде болбойт,
      // эгер аны атайын кошпосоңуз. Figma'да ал бар.
    );
  }
}
