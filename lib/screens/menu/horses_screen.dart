import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/core/app_logo.dart';

class HorsesScreen extends StatefulWidget {
  final int bottomBarCurrentIndex;

  const HorsesScreen({super.key, this.bottomBarCurrentIndex = 0});

  @override
  State<HorsesScreen> createState() => _HorsesScreenState();
}

class _HorsesScreenState extends State<HorsesScreen> {
  // Демейки боюнча эч бир баскыч тандалбайт
  int selectedButtonIndex = -1; 

  @override
  Widget build(BuildContext context) {
    const String categoryTitle = "Жылкы";
    final Color figmaGreen = const Color(0xFF38A169);

    final List<TopicListItemModel> horseTopics = [
      TopicListItemModel(
        id: 'horses_feeding',
        imagePath: 'assets/icons/menu/vector_bodo1.svg', // Тоюттануусу иконкасы (Figma'дагыдай)
        title: 'Тоюттануусу',
        description: 'Жылкыларды туура тоюттандыруу боюнча маалымат.',
        fullDescription: 'Жылкыларды тоюттандыруунун негиздери, рацион түзүү, негизги тоют түрлөрү жана алардын мааниси жөнүндө кеңири маалымат.'
      ),
      TopicListItemModel(
        id: 'horses_diseases',
        imagePath: 'assets/icons/menu/vector_bodo2.svg', // Ооруусу иконкасы (Figma'дагыдай)
        title: 'Ооруусу',
        description: 'Жылкылардын негизги оорулары жана алардын алдын алуу.',
        fullDescription: 'Жылкылардын кеңири таралган жугуштуу жана жугушсуз оорулары, алардын белгилери, диагностикасы, дарылоо жана алдын алуу чаралары.'
      ),
      TopicListItemModel(
        id: 'horses_insemination',
        imagePath: 'assets/icons/menu/vector_bodo3.svg', // Уруктандыруу иконкасы (Figma'дагыдай)
        title: 'Уруктандыруу',
        description: 'Жылкыларды уруктандыруу ыкмалары.',
        fullDescription: 'Жылкыларды табигый жана жасалма уруктандыруу, тукум алуу, кулундоо мезгили жана жаш кулундарды багуу боюнча маалыматтар.'
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
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
              width: 327, // Figma'дагыдай өлчөмдөр
              height: 327,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/cattle_chart.png', // Фондогу диаграмма (sheep_goats_screen'дегидей)
                    width: 327,
                    height: 327,
                    fit: BoxFit.contain,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100), // Сүрөттүн тегерек болушу үчүн чоңураак радиус
                    child: Image.asset(
                      'assets/images/horses_banner.png', // Жылкынын баннери
                      width: 180, // Өлчөмдөрүн Figma'га карап тууралаңыз
                      height: 180,
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
            const SizedBox(height: 30), // Баскычтарга чейинки аралык
            
            ...horseTopics.asMap().entries.map((entry) {
              int idx = entry.key;
              TopicListItemModel topic = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0), // Баскычтардын ортосундагы аралык
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
                      // Тиешелүү экранга навигация
                      if (topic.id == 'horses_feeding') {
                        GoRouter.of(context).pushNamed(RouteNames.horseFeeding);
                      } else if (topic.id == 'horses_diseases') {
                        GoRouter.of(context).pushNamed(RouteNames.horseDiseases);
                      } else if (topic.id == 'horses_insemination') {
                        GoRouter.of(context).pushNamed(RouteNames.horseInsemination);
                      }
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
        : BorderSide(color: figmaGreen.withOpacity(0.5), width: 1.5); // Figma'дагыдай ичке чек

    return SizedBox( // ElevatedButton'дун өлчөмүн тактоо үчүн
      width: 300, // Баскычтын туурасы (Figma'га карап)
      height: 56,  // Баскычтын бийиктиги (Figma'га карап)
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          padding: EdgeInsets.zero, // Ички padding'ди алып салуу
          elevation: isSelected ? 2 : 0, // Тандалганга кичине көлөкө
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28), // Figma'дагыдай тегерек бурчтар
            side: borderSide,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20), // Иконка менен тексттин четинен аралыгы
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start, // Элементтерди солго жайгаштыруу
            children: [
              Container(
                width: 32, // Иконканын тегерегинин өлчөмү
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected ? Colors.white.withOpacity(0.15) : Colors.transparent,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    topic.imagePath,
                    width: 20, // Иконканын өлчөмү
                    height: 20,
                    colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                  ),
                ),
              ),
              const SizedBox(width: 12), // Иконка менен тексттин ортосу
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
