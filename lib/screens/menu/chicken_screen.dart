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
        fullDescription: 'Тооктордун ар кандай породалары, алардын өзгөчөлүктөрү, продуктуулук көрсөткүчтөрү жана багуу шарттарына болгон талаптары жөнүндө кеңири маалымат. Эт, жумуртка жана аралаш багыттагы породалар өзүнчө каралат.',
      ),
      TopicListItemModel(
        id: 'chicken_topic_2',
        imagePath: 'assets/images/chicken_care.jpg',
        title: 'Багуу жана тоюттандыруу',
        description: 'Тоокторду багуу үчүн жай, тоюттандыруу жана оорулардын алдын алуу.',
        fullDescription: 'Тоокторду туура багуу жана тоюттандыруунун негизги принциптери. Тооккананы даярдоо, оптималдуу микроклиматты түзүү, сапаттуу тоюттарды тандоо, рацион түзүү эрежелери жана оорулардын алдын алуу боюнча практикалык кеңештер.',
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
