import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/core/app_logo.dart';

class CattleScreen extends StatefulWidget {
  final int bottomBarCurrentIndex;
  
  const CattleScreen({super.key, this.bottomBarCurrentIndex = 0});

  @override
  State<CattleScreen> createState() => _CattleScreenState();
}

class _CattleScreenState extends State<CattleScreen> {
  // Индекс выбранной кнопки, -1 означает, что ни одна кнопка не выбрана
  int selectedButtonIndex = -1;
  
  @override
  Widget build(BuildContext context) {
    const String categoryTitle = "Бодо мал";
    final Color figmaGreen = const Color(0xFF38A169);

    final List<TopicListItemModel> cattleTopics = [
      TopicListItemModel(
        id: 'cattle_feeding',
        imagePath: 'assets/icons/menu/vector_bodo1.svg',
        title: 'Тоюттануусу',
        description: 'Бодо малды туура тоюттандыруу боюнча маалымат.',
        fullDescription: 'Бодо малды тоюттандыруу – бул жогорку продуктуулуктун жана ден соолуктун негизи. Бул бөлүмдө бодо малдын ар кандай топтору (саан уйлар, бордогуч мал, торпоктор) үчүн тоюттандыруунун илимий негизделген нормалары, рацион түзүү эрежелери, негизги тоют түрлөрү (көк чөп, силос, сенаж, концентраттар, минералдык кошумчалар), алардын аш болумдуулугу жана сапатына койгон талаптар жөнүндө кеңири маалымат берилет. Ошондой эле, тоюттандыруудагы катачылыктардын кесепеттери жана аларды алдын алуу жолдору каралат.'
      ),
      TopicListItemModel(
        id: 'cattle_diseases',
        imagePath: 'assets/icons/menu/vector_bodo2.svg',
        title: 'Ооруусу',
        description: 'Бодо малдын негизги оорулары жана алардын алдын алуу.',
        fullDescription: 'Бодо малдын ден соолугун сактоо – мал чарбасынын маанилүү милдети. Бул жерде бодо малдын кеңири таралган жугуштуу (шарп, кутурма, карасан ж.б.) жана жугушсуз (кеттоз, мастит, ашказан-ичеги оорулары) оорулары, алардын негизги клиникалык белгилери, диагностикалоо ыкмалары, заманбап дарылоо жолдору жана алдын алуу боюнча комплекстүү чаралар (вакцинация, дезинфекция, карантин) тууралуу маалыматтар келтирилген.'
      ),
      TopicListItemModel(
        id: 'cattle_insemination',
        imagePath: 'assets/icons/menu/vector_bodo3.svg',
        title: 'Уруктандыруу',
        description: 'Бодо малды уруктандыруу ыкмалары.',
        fullDescription: 'Бодо малды уруктандыруу – бул тукум алуунун жана малдын санын көбөйтүүнүн негизги жолу. Бул бөлүмдө бодо малды табигый жана жасалма уруктандыруу ыкмалары, алардын артыкчылыктары жана кемчиликтери талкууланат. Уйлардын кунаажынга келүү белгилери, уруктандыруу үчүн оптималдуу убакытты аныктоо, уруктун сапатына койгон талаптар жана уруктандыруу техникасы боюнча практикалык кеңештер берилет. Ошондой эле, тукумдук ишти жакшыртуу жана мал чарбасынын натыйжалуулугун жогорулатуу маселелери каралат.'
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
            // Cattle chart with image
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
                    borderRadius: BorderRadius.circular(75),
                    child: Image.asset(
                      'assets/images/bodomal_banner.png', 
                      width: 150, 
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
            // Кнопки - отцентрированы и с возможностью наведения
            Center(
              child: _buildTopicButton(
                context: context,
                topic: cattleTopics[0],
                isHovered: selectedButtonIndex == 0,
                index: 0,
                figmaGreen: figmaGreen
              ),
            ),
            const SizedBox(height: 8),
            
            Center(
              child: _buildTopicButton(
                context: context,
                topic: cattleTopics[1],
                isHovered: selectedButtonIndex == 1,
                index: 1,
                figmaGreen: figmaGreen
              ),
            ),
            const SizedBox(height: 8),
            
            Center(
              child: _buildTopicButton(
                context: context,
                topic: cattleTopics[2],
                isHovered: selectedButtonIndex == 2,
                index: 2,
                figmaGreen: figmaGreen
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
  
  // Обновленный метод для создания кнопок с реакцией на наведение
  Widget _buildTopicButton({
    required BuildContext context,
    required TopicListItemModel topic,
    required bool isHovered,
    required int index,
    required Color figmaGreen,
  }) {
    return MouseRegion(
      onEnter: (_) => setState(() => selectedButtonIndex = index),
      onExit: (_) => setState(() => selectedButtonIndex = -1),
      child: Container(
        width: 280, // Фиксированная ширина
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 4),
        child: ElevatedButton(
          onPressed: () => _navigateToTopic(context, topic),
          style: ElevatedButton.styleFrom(
            // Здесь меняем цвет кнопки при наведении на зеленый
            backgroundColor: isHovered ? figmaGreen : Colors.white,
            foregroundColor: isHovered ? Colors.white : Colors.black,
            padding: EdgeInsets.zero,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
              side: isHovered 
                ? BorderSide.none 
                : BorderSide(color: figmaGreen, width: 1),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Круглый контейнер для иконки
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isHovered 
                      ? Colors.white.withOpacity(0.2) // Полупрозрачный белый для наведения
                      : Colors.transparent,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      topic.imagePath,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        isHovered ? Colors.white : figmaGreen, // Меняем цвет иконки
                        BlendMode.srcIn
                      ),
                      fit: BoxFit.contain,
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                ),
                
                // Центрированный текст
                Expanded(
                  child: Center(
                    child: Text(
                      topic.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isHovered ? Colors.white : Colors.black, // Цвет текста тоже меняется
                      ),
                    ),
                  ),
                ),
                
                // Пространство для баланса
                SizedBox(width: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  void _navigateToTopic(BuildContext context, TopicListItemModel topic) {
    if (topic.id == 'cattle_feeding') {
      GoRouter.of(context).pushNamed(RouteNames.cattleFeed);
    } else if (topic.id == 'cattle_diseases') {
      GoRouter.of(context).pushNamed(RouteNames.cattleDiseases);
    } else if (topic.id == 'cattle_insemination') { // ЖАҢЫ ШАРТ КОШУЛДУ
      // "Уруктандыруу" темасы үчүн CattleInseminationScreen'ге багыттоо
      // Бул жерде RouteNames.cattleInsemination деп жаңы роут атын колдонуп жатабыз.
      // Бул роутту GoRouter конфигурацияңызда аныкташыңыз керек.
      GoRouter.of(context).pushNamed(RouteNames.cattleInsemination); // Өзүңүздүн роут атыңызды колдонуңуз
    } else {
      GoRouter.of(context).pushNamed(
        RouteNames.topicDetail,
        extra: {'topic': topic, 'currentIndex': widget.bottomBarCurrentIndex},
      );
    }
  }
}
