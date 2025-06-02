import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/core/app_logo.dart';

class SheepInseminationScreen extends StatefulWidget {
  final int bottomBarCurrentIndex;

  const SheepInseminationScreen({super.key, this.bottomBarCurrentIndex = 0});

  @override
  State<SheepInseminationScreen> createState() => _SheepInseminationScreenState();
}

class _SheepInseminationScreenState extends State<SheepInseminationScreen> {
  @override
  Widget build(BuildContext context) {
    const String categoryTitle = "Уруктандыруу";

    final List<TopicListItemModel> inseminationTopics = [
      TopicListItemModel(
        id: 'insemination_large_topic',
        imagePath: 'assets/images/uruk_sheep_banner.png', 
        title: '', 
        description: 'Lorem Ipsum is simply dummy text of the printing', 
        fullDescription: 'Толук сүрөттөмөсү бул жерде болот...'
      ),
      TopicListItemModel(
        id: 'insemination_small_topic_1',
        imagePath: 'assets/images/insemination_topic_small1.png', 
        title: 'Уруктандыруу ыкмалары', 
        description: 'Lorem Ipsum is simply dummy text of the',
        fullDescription: 'Толук сүрөттөмөсү...'
      ),
      TopicListItemModel(
        id: 'insemination_small_topic_2',
        imagePath: 'assets/images/insemination_topic_small2.png', 
        title: 'Урук тандоо',
        description: 'Lorem Ipsum is simply dummy text of the',
        fullDescription: 'Толук сүрөттөмөсү...'
      ),
      TopicListItemModel(
        id: 'insemination_small_topic_3',
        imagePath: 'assets/images/insemination_topic_small3.png', 
        title: 'Бооз мезгили',
        description: 'Lorem Ipsum is simply dummy text of the',
        fullDescription: 'Толук сүрөттөмөсү...'
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => GoRouter.of(context).go(RouteNames.goats), 
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
            if (inseminationTopics.isNotEmpty)
              _buildLargeTopicCard(context, inseminationTopics.first),
            
            const SizedBox(height: 16),
            if (inseminationTopics.length > 1)
              ...inseminationTopics.skip(1).map((topic) => _buildSmallTopicCard(context, topic)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildLargeTopicCard(BuildContext context, TopicListItemModel topic) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () => _navigateToTopic(context, topic),
        borderRadius: BorderRadius.circular(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
              child: Image.asset( 
                topic.imagePath, 
                width: double.infinity,
                height: 180, 
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 180,
                  color: Colors.grey[200],
                  child: const Center(child: Icon(Icons.broken_image, size: 50)),
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

  Widget _buildSmallTopicCard(BuildContext context, TopicListItemModel topic) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 2,
      child: InkWell(
        onTap: () => _navigateToTopic(context, topic),
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset( 
                  topic.imagePath,
                  width: 60, 
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 60, height: 60, color: Colors.grey[200],
                    child: Icon(Icons.broken_image, size: 30, color: Colors.grey[400]),
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
                        fontSize: 15, 
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      topic.description,
                      style: TextStyle(
                        fontSize: 13, 
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
