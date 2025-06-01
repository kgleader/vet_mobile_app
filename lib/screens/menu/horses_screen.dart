import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/core/app_logo.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';

class HorsesScreen extends StatelessWidget {
  final int bottomBarCurrentIndex;
  
  const HorsesScreen({super.key, this.bottomBarCurrentIndex = 0});

  @override
  Widget build(BuildContext context) {
    // const String categoryTitle = 'Жылкылар'; // Removed as unused
    const String bannerImagePath = 'assets/images/horses_banner.png';
    const String bannerDescription = 'remrem ipsum dolor sit amet, consectetur adipiscing elit. Nulla faci';
    final List<TopicListItemModel> topics = [
      TopicListItemModel(
        id: 'horses_blog_1',
        imagePath: 'assets/images/horse_topic1.png',
        title: 'Blog post 1',
        description: 'What is Lorem Ipsum Lorem Ipsum',
        fullDescription: 'Жылкылардын биринчи блогунун толук маалыматы. Бул жерде жылкылардын ден соолугу, тукумдары жана башка кызыктуу маалыматтар камтылган.',
      ),
      TopicListItemModel(
        id: 'horses_blog_2',
        imagePath: 'assets/images/horse_topic2.png',
        title: 'Blog post 2',
        description: 'What is Lorem Ipsum Lorem Ipsum',
        fullDescription: 'Жылкылар жөнүндө экинчи блогдун кеңири баяндамасы. Бул бөлүмдө жылкыларды багуу, үйрөтүү жана алардын өзгөчөлүктөрү тууралуу сөз болот.',
      ),
      TopicListItemModel(
        id: 'horses_blog_3',
        imagePath: 'assets/images/horse_topic3.png',
        title: 'Blog post 3',
        description: 'What is Lorem Ipsum Lorem Ipsum',
        fullDescription: 'Үчүнчү блог жылкылардын тарыхы, маданияттагы орду жана азыркы учурдагы маанисине арналган. Көбүрөөк маалымат алыңыз.',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => GoRouter.of(context).go(RouteNames.menu),
        ),
        title: const Text(
          'Жылкылар',
          style: TextStyle(
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
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Banner image
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: AssetImage(bannerImagePath),
                fit: BoxFit.cover,
              ),
            ),
            margin: const EdgeInsets.only(bottom: 16),
          ),

          // Description
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: Text(
              bannerDescription,
              style: const TextStyle(fontSize: 16),
            ),
          ),

          // Topics list
          ...topics.map((topic) => _buildTopicCard(context, topic)),
        ],
      ),
    );
  }

  Widget _buildTopicCard(BuildContext context, TopicListItemModel topic) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          GoRouter.of(context).pushNamed(
            RouteNames.topicDetail,
            extra: {
              'topic': topic,
              'currentIndex': 0,
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Topic image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  topic.imagePath,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[300],
                      child: const Icon(Icons.error),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              
              // Topic content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      topic.description,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Arrow icon
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
