// /Users/meerimakmatova/vet_mobile_app/lib/screens/menu/insemination_screen.dart
import 'package:flutter/material.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/screens/menu/category_screen.dart';

class InseminationScreen extends StatelessWidget {
  const InseminationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<TopicListItemModel> inseminationTopics = [
      TopicListItemModel(
        id: 'insemination_topic_1',
        imagePath: 'assets/images/insemination1.png',
        title: 'Табигый уруктандыруу',
        description: 'Малды табигый жол менен уруктандыруу ыкмалары.',
        fullDescription: 'Табигый уруктандыруу – бул малды көбөйтүүнүн салттуу жана кеңири таралган ыкмасы. Бул бөлүмдө табигый уруктандыруунун артыкчылыктары (жөнөкөйлүгү, атайын жабдуулардын кереги жоктугу) жана кемчиликтери (тукумдук малдын сапатын көзөмөлдөөнүн татаалдыгы, оорулардын жугуу коркунучу) каралат. Ошондой эле, ар кандай мал түрлөрүндө (уй, кой, жылкы) табигый уруктандырууну ийгиликтүү өткөрүү үчүн оптималдуу шарттар, кунаажынга келүү белгилери жана уруктандыруу убактысын туура аныктоо боюнча кеңештер берилет.',
      ),
      TopicListItemModel(
        id: 'insemination_topic_2',
        imagePath: 'assets/images/insemination2.png',
        title: 'Жасалма уруктандыруу',
        description: 'Заманбап технологияларды колдонуу.',
        fullDescription: 'Жасалма уруктандыруу – мал чарбасындагы тукум жакшыртуунун жана продуктуулукту жогорулатуунун негизги ыкмаларынын бири. Бул жерде жасалма уруктандыруунун негизги принциптери, анын артыкчылыктары (мыкты тукумдук малдын генетикасын кеңири колдонуу, оорулардын жугуу коркунучун азайтуу, экономикалык натыйжалуулук) жана кемчиликтери (атайын билимди, жабдууларды жана шарттарды талап кылуусу) талкууланат. Урукту алуу, сактоо, эритүү жана кунаажынга куюу технологиялары боюнча маалымат берилет.',
      ),
      TopicListItemModel(
        id: 'insemination_topic_3',
        imagePath: 'assets/images/insemination3.png',
        title: 'Тукум тандоо',
        description: 'Малдын тукумун жакшыртуу жолдору.',
        fullDescription: 'Тукум тандоо – бул мал чарбасындагы селекциялык иштин маанилүү бөлүгү. Бул бөлүмдө малдын тукумдук сапаттарын жакшыртууда тукум тандоонун негизги максаттары жана милдеттери каралат. Мыкты тукумдук эркек жана ургаачы малды тандоо критерийлери (экстерьери, продуктуулугу, ден соолугу, тукумдук сапаттары) жана аларды баалоо ыкмалары жөнүндө сөз болот. Ошондой эле, генетикалык потенциалды жогорулатуу, инбридингди болтурбоо жана малдын тукумдук курамын жакшыртуу боюнча практикалык сунуштар берилет.',
      ),
    ];

    return CategoryScreen(
      title: 'Уруктандыруу',
      bannerImagePath: 'assets/images/muzoo_banner.png',
      bannerDescription: 'Малды уруктандыруунун заманбап ыкмалары.',
      topics: inseminationTopics,
    );
  }
}