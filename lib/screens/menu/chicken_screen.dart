import 'package:flutter/material.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/screens/menu/category_screen.dart';

class ChickenScreen extends StatelessWidget {
  const ChickenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String categoryTitle = 'Тоок';
    const String bannerImagePath = 'assets/images/chicken_banner.jpg';
    const String bannerDescription = 'Тоок чарбасы, тоок багуу жана жумуртка өндүрүү.';
    final List<TopicListItemModel> chickenTopics = [
      TopicListItemModel(
        id: 'chicken_topic_1',
        imagePath: 'assets/images/chicken_breeds.jpg',
        title: 'Породалары',
        description: 'Тооктордун эт багытындагы, жумуртка багытындагы жана аралаш породалары.',
        fullDescription: 'Ар кандай багыттагы тоок породалары, алардын продуктуулугу, ооруларга туруктуулугу жана багуу шарттарына болгон талаптары.',
      ),
      TopicListItemModel(
        id: 'chicken_topic_2',
        imagePath: 'assets/images/chicken_care.jpg',
        title: 'Багуу жана тоюттандыруу',
        description: 'Тоокторду багуу үчүн жай, тоюттандыруу жана оорулардын алдын алуу.',
        fullDescription: 'Тоокторду кармоо үчүн жайларды даярдоо, оптималдуу температуралык режим, жарыктандыруу, тоюттандыруу рационун түзүү жана оорулардын алдын алуу чаралары.',
      ),
    ];

    return CategoryScreen(
      title: categoryTitle,
      bannerImagePath: bannerImagePath,
      bannerDescription: bannerDescription,
      topics: chickenTopics,
    );
  }
}
