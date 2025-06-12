// Бул файл "Жылкылардын тоюту" категориясына тиешелүү маалыматты (негизги тоюттар, кошумча тоюттар ж.б.) көрсөтүүчү экранды аныктайт.
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/core/app_logo.dart';

class HorseFeedingScreen extends StatefulWidget {
  final int bottomBarCurrentIndex;

  const HorseFeedingScreen({super.key, this.bottomBarCurrentIndex = 0});

  @override
  State<HorseFeedingScreen> createState() => _HorseFeedingScreenState();
}

class _HorseFeedingScreenState extends State<HorseFeedingScreen> {
  @override
  Widget build(BuildContext context) {
    const String categoryTitle = "Тоют"; 

    
    final List<TopicListItemModel> feedingTopics = [
      TopicListItemModel( 
        id: 'horse__feed_banner',
        imagePath: 'assets/images/horse_toyut_banner.png', 
        title: '', 
        description: 'Lorem Ipsum is simply dummy text of the printing', 
        fullDescription: 'Жылкылардын негизги тоюттары жана алардын мааниси жөнүндө толук маалымат.'
      ),
      TopicListItemModel(
        id: 'horse_feeding_topic_1',
        imagePath: 'assets/images/horse_topic1.png', 
        title: 'Тоют', 
        description: 'Lorem Ipsum is simply dummy text of the', 
        fullDescription: 'Жылкылар үчүн биринчи теманын толук сүрөттөмөсү.'
      ),
      TopicListItemModel(
        id: 'horse_feeding_topic_2',
        imagePath: 'assets/images/horse_topic2.png', 
        title: 'Тоют', 
        description: 'Lorem Ipsum is simply dummy text of the', 
        fullDescription: 'Жылкылар үчүн экинчи теманын толук сүрөттөмөсү.'
      ),
      TopicListItemModel( 
        id: 'horse_feeding_topic_3',
        imagePath: 'assets/images/horse_topic3.png', 
        title: 'Тоют', 
        description: 'Lorem Ipsum is simply dummy text of the', 
        fullDescription: 'Жылкылар үчүн үчүнчү теманын толук сүрөттөмөсү.'
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          
          onPressed: () => GoRouter.of(context).go(RouteNames.horses), 
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
            padding: EdgeInsets.only(right: Sizes.paddingXL),
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
