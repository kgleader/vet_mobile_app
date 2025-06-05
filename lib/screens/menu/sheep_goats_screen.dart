import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/core/app_logo.dart';

class SheepGoatsScreen extends StatefulWidget {
  final int bottomBarCurrentIndex;
  
  const SheepGoatsScreen({super.key, this.bottomBarCurrentIndex = 0});

  @override
  State<SheepGoatsScreen> createState() => _SheepGoatsScreenState();
}

class _SheepGoatsScreenState extends State<SheepGoatsScreen> {
  int selectedButtonIndex = -1;
  
  @override
  Widget build(BuildContext context) {
    const String categoryTitle = "Кой эчкилер"; 
    final Color figmaGreen = const Color(0xFF38A169);

    final List<TopicListItemModel> cattleTopics = [
      TopicListItemModel(
        id: 'goats_feeding',
        imagePath: 'assets/icons/menu/vector_bodo1.svg',
        title: 'Тоюттануусу',
        description: 'Койлорду туура тоюттандыруу боюнча маалымат.',
        fullDescription: 'Койлорду тоюттандыруу – бул жогорку продуктуулуктун жана ден соолуктун негизи. Бул бөлүмдө койлордун ар кандай топтору (саан койлор, бордогуч койлор) үчүн тоюттандыруунун илимий негизделген нормалары, рацион түзүү эрежелери, негизги тоют түрлөрү (көк чөп, силос, сенаж, концентраттар, минералдык кошумчалар), алардын аш болумдуулугу жана сапатына койгон талаптар жөнүндө кеңири маалымат берилет. Ошондой эле, тоюттандыруудагы катачылыктардын кесепеттери жана аларды алдын алуу жолдору каралат.'
      ),
      TopicListItemModel(
        id: 'goats_diseases',
        imagePath: 'assets/icons/menu/vector_bodo2.svg',
        title: 'Ооруусу',
        description: 'Койлордун негизги оорулары жана алардын алдын алуу.',
        fullDescription: 'Койлордун ден соолугун сактоо – мал чарбасынын маанилүү милдети. Бул жерде койлордун кеңири таралган жугуштуу (шарп, кутурма, карасан ж.б.) жана жугушсуз (кеттоз, мастит, ашказан-ичеги оорулары) оорулары, алардын негизги клиникалык белгилери, диагностикалоо ыкмалары, заманбап дарылоо жолдору жана алдын алуу боюнча комплекстүү чаралар (вакцинация, дезинфекция, карантин) тууралуу маалыматтар келтирилген.'
      ),
      TopicListItemModel(
        id: 'goats_insemination',
        imagePath: 'assets/icons/menu/vector_bodo3.svg',
        title: 'Уруктандыруу',
        description: 'Койлорду уруктандыруу ыкмалары.',
        fullDescription: 'Койлорду уруктандыруу – бул тукум алуунун жана малдын санын көбөйтүүнүн негизги жолу. Бул бөлүмдө койлорду табигый жана жасалма уруктандыруу ыкмалары, алардын артыкчылыктары жана кемчиликтери талкууланат. Уйлардын кунаажынга келүү белгилери, уруктандыруу үчүн оптималдуу убакытты аныктоо, уруктун сапатына койгон талаптар жана уруктандыруу техникасы боюнча практикалык кеңештер берилет. Ошондой эле, тукумдук ишти жакшыртуу жана мал чарбасынын натыйжалуулугун жогорулатуу маселелери каралат.'
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
                    borderRadius: BorderRadius.circular(75), 
                    child:  Image.asset(
                      'assets/images/sheep_banner.png', 
                      width: 150, 
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            
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
        width: 280, 
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: ElevatedButton(
          onPressed: () {
            if (topic.id == 'goats_feeding') {
              GoRouter.of(context).pushNamed(RouteNames.sheepFeeding);
            } else if (topic.id == 'goats_diseases') {
              GoRouter.of(context).pushNamed(RouteNames.sheepDiseases);
            } else if (topic.id == 'goats_insemination') { // "Уруктандыруу" үчүн шарт
              GoRouter.of(context).pushNamed(RouteNames.sheepInsemination);
            } else {
              _navigateToTopic(context, topic);
            }
          },
          style: ElevatedButton.styleFrom(
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
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isHovered 
                      ? Colors.white.withOpacity(0.2) 
                      : Colors.transparent,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      topic.imagePath,
                      width: 24,
                      height: 24,
                      colorFilter: ColorFilter.mode(
                        isHovered ? Colors.white : figmaGreen, 
                        BlendMode.srcIn
                      ),
                      fit: BoxFit.contain,
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                ),
                
                Expanded(
                  child: Center(
                    child: Text(
                      topic.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isHovered ? Colors.white : Colors.black, 
                      ),
                    ),
                  ),
                ),
                
                SizedBox(width: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  void _navigateToTopic(BuildContext context, TopicListItemModel topic) {
    GoRouter.of(context).pushNamed(
      RouteNames.topicDetail,
      extra: {'topic': topic, 'currentIndex': widget.bottomBarCurrentIndex}, // widget.bottomBarCurrentIndex колдонуу
    );
  }
}
