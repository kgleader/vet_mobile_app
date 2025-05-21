// /Users/meerimakmatova/vet_mobile_app/lib/screens/menu/diseases_screen.dart
import 'package:flutter/material.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/screens/menu/category_screen.dart';

class DiseasesScreen extends StatelessWidget { // Класстын атын DiseasesScreen деп өзгөртсөңүз болот
  const DiseasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TopicListItemModel> diseaseTopics = [
      TopicListItemModel(
        id: 'disease_topic_1',
        imagePath: 'assets/images/disease_topic1.jpg',
        title: 'Ооруу',
        description: 'Lorem Ipsum is simply dummy text of the',
        fullDescription: 'Бул бөлүмдө малдын жугуштуу оорулары, алардын негизги белгилери, диагностикалоо ыкмалары жана заманбап дарылоо жолдору жөнүндө кеңири маалымат берилет. Ошондой эле, оорулардын алдын алуу жана чарбада эпизоотиялык кырдаалды көзөмөлдөө боюнча сунуштар камтылган.'
      ),
      TopicListItemModel(
        id: 'disease_topic_2',
        imagePath: 'assets/images/disease_topic2.jpg',
        title: 'Ооруу',
        description: 'Lorem Ipsum is simply dummy text of the',
        fullDescription: 'Малдын мите курттардан пайда болуучу оорулары (гельминтоздор) жана алардын экономикалык зыяны тууралуу маалымат. Гельминтоздордун түрлөрү, аларды аныктоо, дарылоо жана алдын алуу боюнча комплекстүү чаралар, дегельминтизациялоо схемалары келтирилген.'
      ),
      TopicListItemModel(
        id: 'disease_topic_3',
        imagePath: 'assets/images/disease_topic3.jpg',
        title: 'Ооруу',
        description: 'Lorem Ipsum is simply dummy text of the',
        fullDescription: 'Малдын зат алмашуу процесстеринин бузулушунан келип чыккан оорулар (мисалы, кетоз, остеодистрофия ж.б.) жана алардын себептери. Бул оорулардын клиникалык белгилери, диагностикасы, дарылоо принциптери жана тоюттандырууну оптималдаштыруу аркылуу алдын алуу жолдору баяндалат.'
      ),
    ];

    return CategoryScreen(
      title: 'Ооруу', // UPDATED to match Figma AppBar
      bannerImagePath: 'assets/images/grass_banner.jpg', // UPDATED to use grass_banner.jpg
      bannerDescription: 'Lorem Ipsum is simply dummy text of the printing', // UPDATED to match Figma banner text
      topics: diseaseTopics,
    );
  }
}