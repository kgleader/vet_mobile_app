import 'package:flutter/material.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/screens/menu/category_screen.dart';

class HorsesScreen extends StatelessWidget {
  const HorsesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String categoryTitle = 'Жылкылар';
    const String bannerImagePath = 'assets/images/horses_banner.png';
    const String bannerDescription = 'remrem ipsum dolor sit amet, consectetur adipiscing elit. Nulla faci';
    final List<TopicListItemModel> topics = [
      TopicListItemModel(
        id: 'horses_blog_1',
        imagePath: 'assets/images/horse_topic1.png',
        title: 'Blog post 1',
        description: 'What is Lorem Ipsum Lorem Ipsum',
        fullDescription: 'Толук маалымат Blog post 1 жөнүндө жылкылар темасында.',
      ),
      TopicListItemModel(
        id: 'horses_blog_2',
        imagePath: 'assets/images/horse_topic2.png',
        title: 'Blog post 2',
        description: 'What is Lorem Ipsum Lorem Ipsum',
        fullDescription: 'Толук маалымат Blog post 2 жөнүндө жылкылар темасында.',
      ),
      TopicListItemModel(
        id: 'horses_blog_3',
        imagePath: 'assets/images/horse_topic3.png',
        title: 'Blog post 3',
        description: 'What is Lorem Ipsum Lorem Ipsum',
        fullDescription: 'Толук маалымат Blog post 3 жөнүндө жылкылар темасында.',
      ),
    ];

    return CategoryScreen(
      title: categoryTitle,
      bannerImagePath: bannerImagePath,
      bannerDescription: bannerDescription,
      topics: topics,
    );
  }
}
