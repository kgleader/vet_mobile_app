import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/core/app_logo.dart';

class ChickenFeedingScreen extends StatefulWidget {
  final int bottomBarCurrentIndex;

  const ChickenFeedingScreen({super.key, this.bottomBarCurrentIndex = 0});

  @override
  State<ChickenFeedingScreen> createState() => _ChickenFeedingScreenState();
}

class _ChickenFeedingScreenState extends State<ChickenFeedingScreen> {
  @override
  Widget build(BuildContext context) {
    const String categoryTitle = "Тоют";

    final List<TopicListItemModel> feedingTopics = [
      TopicListItemModel( 
        id: 'chicken_feed_banner_topic',
        imagePath: 'assets/images/chicken_feeding_banner.png', 
        title: '', 
        description: 'Тоокторду туура тоюттандыруунун негиздери.', 
        fullDescription: 'Тооктор үчүн негизги тоюттар, рацион түзүү жана кошумча азыктар жөнүндө толук маалымат.'
      ),
      TopicListItemModel(
        id: 'chicken_feeding_topic_1',
        imagePath: 'assets/images/chicken_feed_topic1.png', 
        title: 'Негизги тоюттар',
        description: 'Дан, жашылча жана башка негизги тоюттар.',
        fullDescription: 'Тооктор үчүн негизги тоют түрлөрү, алардын курамы жана пайдасы.'
      ),
      TopicListItemModel(
        id: 'chicken_feeding_topic_2',
        imagePath: 'assets/images/chicken_feed_topic2.png', 
        title: 'Кошумча азыктар',
        description: 'Витаминдер, минералдар жана башка кошумчалар.',
        fullDescription: 'Тооктордун жумуртка туушун жана ден соолугун жакшыртуу үчүн кошумча азыктар.'
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => GoRouter.of(context).go(RouteNames.chicken), 
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
            if (feedingTopics.isNotEmpty)
              _buildLargeTopicCard(context, feedingTopics.first),
            
            const SizedBox(height: 16), 
            
            if (feedingTopics.length > 1)
              ...feedingTopics.skip(1).map((topic) { 
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
