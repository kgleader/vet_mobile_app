import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/core/app_logo.dart';

class ChickenDiseasesScreen extends StatefulWidget {
  final int bottomBarCurrentIndex;

  const ChickenDiseasesScreen({super.key, this.bottomBarCurrentIndex = 0});

  @override
  State<ChickenDiseasesScreen> createState() => _ChickenDiseasesScreenState();
}

class _ChickenDiseasesScreenState extends State<ChickenDiseasesScreen> {
  @override
  Widget build(BuildContext context) {
    const String categoryTitle = "Дарылоо";

    final List<TopicListItemModel> diseaseTopics = [
      TopicListItemModel( 
        id: 'chicken_disease_banner_topic',
        imagePath: 'assets/images/chicken_diseases_banner.png', 
        title: '', 
        description: 'Тооктордун негизги оорулары жана аларды дарылоо.', 
        fullDescription: 'Тооктордун жугуштуу жана жугушсуз оорулары, алардын белгилери, диагностикасы жана заманбап дарылоо ыкмалары жөнүндө толук маалымат.'
      ),
      TopicListItemModel(
        id: 'chicken_disease_topic_1',
        imagePath: 'assets/images/chicken_disease_topic1.png', 
        title: 'Жугуштуу оорулар',
        description: 'Ньюкасл, Марек, сальмонеллез ж.б.',
        fullDescription: 'Тооктордун кеңири таралган жугуштуу оорулары, алардын алдын алуу жана дарылоо.'
      ),
      TopicListItemModel(
        id: 'chicken_disease_topic_2',
        imagePath: 'assets/images/chicken_disease_topic2.png', 
        title: 'Мите курттар',
        description: 'Ички жана сырткы мите курттар менен күрөшүү.',
        fullDescription: 'Тооктордун мите курт оорулары, алардын зыяны жана дарылоо жолдору.'
      ),
      TopicListItemModel(
        id: 'chicken_disease_topic_3',
        imagePath: 'assets/images/chicken_disease_topic3.png', 
        title: 'Профилактика',
        description: 'Ооруларды алдын алуу боюнча негизги чаралар.',
        fullDescription: 'Тооккананы таза кармоо, туура тоюттандыруу жана вакцинация аркылуу оорулардын алдын алуу.'
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => GoRouter.of(context).go(RouteNames.chicken), // "Тоок" негизги экранына кайтуу
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
        child: ListView( 
          children: [
            const SizedBox(height: 24),
            const Align( 
              alignment: Alignment.centerLeft,
              child: Text(
                "Тема",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 12),
            if (diseaseTopics.isNotEmpty)
              _buildLargeTopicCard(context, diseaseTopics.first),
            
            const SizedBox(height: 16), 
            
            if (diseaseTopics.length > 1)
              ...diseaseTopics.skip(1).map((topic) { 
                return _buildSmallTopicCard(
                  context: context,
                  topic: topic,
                );
              }),
            const SizedBox(height: 20), 
          ],
        ),
      ),
    );
  }

  Widget _buildLargeTopicCard(BuildContext context, TopicListItemModel topic) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 0),
      child: InkWell(
        onTap: () => _navigateToTopic(context, topic),
        borderRadius: BorderRadius.circular(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              child: Image.asset(
                topic.imagePath,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 180,
                  color: Colors.grey[200],
                  child: const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                topic.description,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallTopicCard({
    required BuildContext context,
    required TopicListItemModel topic,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 2,
      child: InkWell(
        onTap: () => _navigateToTopic(context, topic),
        borderRadius: BorderRadius.circular(20.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset( 
                  topic.imagePath,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                   errorBuilder: (context, error, stackTrace) => Container(
                    width: 60, height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Icon(Icons.broken_image, color: Colors.grey[400], size: 30)
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      topic.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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
    GoRouter.of(context).pushNamed(
      RouteNames.topicDetail,
      extra: {'topic': topic, 'currentIndex': widget.bottomBarCurrentIndex},
    );
  }
}
