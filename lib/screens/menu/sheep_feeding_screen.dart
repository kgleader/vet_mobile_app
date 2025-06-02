import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/core/app_logo.dart';

class SheepFeedingScreen extends StatefulWidget {
  final int bottomBarCurrentIndex; // Талаа кошулду

  // Конструктор жаңыртылды, bottomBarCurrentIndex параметрин кабыл алат (демейки мааниси 0)
  const SheepFeedingScreen({super.key, this.bottomBarCurrentIndex = 0});

  @override
  State<SheepFeedingScreen> createState() => _SheepFeedingScreenState();
}

class _SheepFeedingScreenState extends State<SheepFeedingScreen> {
  // selectedButtonIndex эми колдонулбайт, эгер карта басылганда атайын эффект жок болсо
  // int selectedButtonIndex = -1; 

  @override
  Widget build(BuildContext context) {
    const String categoryTitle = "Тоюттануусу";
    // final Color figmaGreen = const Color(0xFF38A169); // Эгер картанын стилинде керек болсо

    final List<TopicListItemModel> feedingTopics = [
      TopicListItemModel(
        id: 'feeding_topic_1',
        imagePath: 'assets/images/sheep_toyut_topic1.png', // Сүрөттү SVG ордуна PNG колдондук
        title: 'Негизги тоюттар', 
        description: 'Койлор үчүн негизги тоют түрлөрү, алардын курамы жана пайдасы тууралуу маалымат.', // Сүрөттөмөнү узагыраак кылдым
        fullDescription: 'Бул жерде койлор үчүн негизги тоют түрлөрү, алардын курамы жана пайдасы тууралуу маалымат берилет.'
      ),
      TopicListItemModel(
        id: 'feeding_topic_2',
        imagePath: 'assets/images/sheep_toyut_topic2.png', // Сүрөттү SVG ордуна PNG колдондук
        title: 'Рацион түзүү', 
        description: 'Койлордун рационун туура түзүү эрежелери жана принциптери.', // Сүрөттөмөнү узагыраак кылдым
        fullDescription: 'Койлордун жашына, жынысына жана физиологиялык абалына жараша рацион түзүүнүн негизги принциптери жана эрежелери.'
      ),
      TopicListItemModel(
        id: 'feeding_topic_3',
        imagePath: 'assets/images/sheep_toyut_topic3.png', // Сүрөттү SVG ордуна PNG колдондук  
        title: 'Кошумча азыктар', 
        description: 'Койлор үчүн кошумча азыктар, витаминдер жана минералдар.', // Сүрөттөмөнү узагыраак кылдым
        fullDescription: 'Койлордун ден соолугун чыңдоо жана продуктуулугун жогорулатуу үчүн колдонулуучу кошумча азыктар, минералдар жана витаминдер.'
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          // Артка кайтууну "Кой эчкилер" экранына багыттоо
          onPressed: () => GoRouter.of(context).go(RouteNames.goats), // RouteNames.goats "Кой эчкилер" үчүн
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
              width: double.infinity, 
              height: 180, 
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0), 
                child: Image.asset( // SvgPicture.asset ордуна Image.asset
                  'assets/images/sheep_toyut_banner.png', 
                  fit: BoxFit.cover,
                  // Эгер сүрөт жүктөлбөсө, катаны көрсөтүү үчүн errorBuilder колдонсо болот
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(child: Text('Сүрөт жүктөлбөдү', textAlign: TextAlign.center,))
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            Expanded(
              child: ListView.builder(
                itemCount: feedingTopics.length,
                itemBuilder: (context, index) {
                  // _buildTopicButton ордуна _buildTopicCard колдонобуз
                  return _buildTopicCard(
                    context: context,
                    topic: feedingTopics[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  // _buildTopicButton ордуна жаңы _buildTopicCard методу
  Widget _buildTopicCard({
    required BuildContext context,
    required TopicListItemModel topic,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 2, // Кичине көлөкө
      child: InkWell(
        onTap: () => _navigateToTopic(context, topic),
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset( // SvgPicture.asset ордуна Image.asset
                  topic.imagePath, // Картанын ичиндеги сүрөт (PNG)
                  width: 80, // Сүрөттүн өлчөмү
                  height: 80,
                  fit: BoxFit.cover,
                  // Эгер PNG сүрөтү жүктөлбөсө, errorBuilder колдонулат
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Container(
                      width: 80, height: 80, color: Colors.grey[200],
                      child: Icon(Icons.broken_image, color: Colors.grey[400]) // placeholderBuilder ордуна errorBuilder
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.title, // Figma'да "Тоют", бул жерде конкреттүү аталыш
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      topic.description, // Figma'да "Lorem Ipsum", бул жерде конкреттүү сүрөттөмө
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                      maxLines: 2, // Сүрөттөмөнү 2 сапка чектөө
                      overflow: TextOverflow.ellipsis, // Эгер узун болсо, ... менен бүтөт
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  void _navigateToTopic(BuildContext context, TopicListItemModel topic) {
    // Бул жерде да TopicDetailScreen'ге өтүү логикасы
    // currentIndex "Тоюттануусу" экранына тиешелүү болушу мүмкүн
    GoRouter.of(context).pushNamed(
      RouteNames.topicDetail,
      extra: {'topic': topic, 'currentIndex': widget.bottomBarCurrentIndex}, // Эми widget.bottomBarCurrentIndex жеткиликтүү
    );
  }
}
