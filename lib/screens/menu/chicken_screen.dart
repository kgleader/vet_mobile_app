// Бул файл "Тоок" категориясына тиешелүү экранды аныктайт. Экранда тооктун сүрөтү (баннер) жана тоок канаттууларга 
// байланыштуу негизги темалар (Тоюттануусу, Оорусу) баскычтар түрүндө көрсөтүлөт. Колдонуучу ар бир баскычты басуу менен 
// тиешелүү деталдуу маалымат баракчасына өтө алат.
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/core/app_logo.dart';

class ChickenScreen extends StatefulWidget {
  final int bottomBarCurrentIndex;

  const ChickenScreen({super.key, this.bottomBarCurrentIndex = 0});

  @override
  State<ChickenScreen> createState() => _ChickenScreenState();
}

class _ChickenScreenState extends State<ChickenScreen> {
  int selectedButtonIndex = -1;

  @override
  Widget build(BuildContext context) {
    const String categoryTitle = "Тоок";
    final Color figmaGreen = const Color(0xFF38A169);

    final List<TopicListItemModel> chickenTopics = [
      TopicListItemModel(
        id: 'chicken_feeding',
        imagePath: 'assets/icons/menu/vector_bodo1.svg',
        title: 'Тоюттануусу',
        description: 'Тоокторду туура тоюттандыруу боюнча маалымат.',
        fullDescription: 'Тоокторду тоюттандыруунун негиздери, рацион түзүү, негизги тоют түрлөрү жана алардын мааниси.'
      ),
      TopicListItemModel(
        id: 'chicken_diseases',
        imagePath: 'assets/icons/menu/vector_bodo2.svg',
        title: 'Ооруусу',
        description: 'Тооктордун негизги оорулары жана алардын алдын алуу.',
        fullDescription: 'Тооктордун кеңири таралган жугуштуу жана жугушсуз оорулары, алардын белгилери, дарылоо жана алдын алуу чаралары.'
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => GoRouter.of(context).go(RouteNames.menu),
        ),
        title: Text(
          categoryTitle,
          style: const TextStyle(
            color: Colors.black,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingL),
        child: Column(
          children: [
            const SizedBox(height: 24),
            SizedBox(
              width: 327,
              height: 327,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/cattle_chart.png',
                    width: 327,
                    height: 327,
                    fit: BoxFit.contain,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100), 
                    child: Image.asset(
                      'assets/images/chicken_banner.png', 
                      width: 160, 
                      height: 160,
                      fit: BoxFit.cover,
                       errorBuilder: (context, error, stackTrace) => Container(
                        width: 180, height: 180, color: Colors.grey[200],
                        child: const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey))
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30), 
            
            ...chickenTopics.asMap().entries.map((entry) {
              int idx = entry.key;
              TopicListItemModel topic = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Center(
                  child: _buildTopicButton(
                    context: context,
                    topic: topic,
                    isSelected: selectedButtonIndex == idx,
                    index: idx,
                    figmaGreen: figmaGreen,
                    onPressed: () {
                      setState(() {
                        selectedButtonIndex = idx;
                      });
                      // НАВИГАЦИЯ ЛОГИКАСЫ
                      if (topic.id == 'chicken_feeding') {
                        GoRouter.of(context).pushNamed(RouteNames.chickenFeeding);
                      } else if (topic.id == 'chicken_diseases') {
                        GoRouter.of(context).pushNamed(RouteNames.chickenDiseases);
                      }
                      // Башка темалар үчүн да ушундай шарттарды кошсоңуз болот
                    },
                  ),
                ),
              );
            }),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicButton({
    required BuildContext context,
    required TopicListItemModel topic,
    required bool isSelected,
    required int index,
    required Color figmaGreen,
    required VoidCallback onPressed,
  }) {
    final Color backgroundColor = isSelected ? figmaGreen : Colors.white;
    final Color foregroundColor = isSelected ? Colors.white : Colors.black;
    final Color iconColor = isSelected ? Colors.white : figmaGreen;
    final BorderSide borderSide = isSelected
        ? BorderSide.none
        : BorderSide(color: figmaGreen.withOpacity(0.5), width: 1.5);

    return SizedBox( 
      width: 300, 
      height: 56,  
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: EdgeInsets.zero, 
          elevation: isSelected ? 2 : 0, 
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28), 
            side: borderSide,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20), 
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start, 
            children: [
              Container(
                width: 32, 
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? Colors.white.withOpacity(0.15) : Colors.transparent,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    topic.imagePath,
                    width: 20, 
                    height: 20,
                    colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                  ),
                ),
              ),
              const SizedBox(width: 12), 
              Text(
                topic.title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: foregroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
