import 'package:flutter/material.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/core/app_logo.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/screens/menu/category_screen.dart';

class HorseInseminationScreen extends StatelessWidget {
  final int bottomBarCurrentIndex;

  const HorseInseminationScreen({super.key, this.bottomBarCurrentIndex = 0});

  @override
  Widget build(BuildContext context) {
    const String categoryTitle = "Уруктандыруу";

    final String bannerImagePath = 'assets/images/uruk_horse_banner.png';
    final String bannerDescription = "Жылкыларды уруктандыруу көйгөйлөрү боюнча кеңири маалыматтар";

    final List<TopicListItemModel> inseminationTopics = [
      TopicListItemModel(
        id: 'horse_insemination_topic_1',
        imagePath: 'assets/images/horse_topic1.png',
        title: 'Уруктандыруу техникасы',
        description: 'Жылкыларды уруктандыруу техникасы жөнүндө маалымат',
        fullDescription: 'Жылкыларды уруктандыруу - бул жылкы чарбачылыгында породаны жакшыртуу үчүн '
            'колдонулуучу маанилүү процесс. Бул бөлүмдө уруктандыруунун ар кандай техникалары, '
            'зарыл шаймандар жана процедуранын жүрүшү жөнүндө кеңири маалымат берилет.'
      ),
      TopicListItemModel(
        id: 'horse_insemination_topic_2',
        imagePath: 'assets/images/horse_topic2.png',
        title: 'Убакыт тандоо',
        description: 'Уруктандыруу үчүн оптималдуу убакытты аныктоо',
        fullDescription: 'Жылкыларды ийгиликтүү уруктандыруу үчүн туура убакытты тандоо өтө маанилүү. '
            'Бул бөлүмдө уруктандыруунун оптималдуу убактысы, бээнин циклынын өзгөчөлүктөрү жана '
            'куулуктун белгилерин аныктоо боюнча кеңири маалыматтар берилген.'
      ),
      TopicListItemModel(
        id: 'horse_insemination_topic_3',
        imagePath: 'assets/images/horse_topic3.png',
        title: 'Жасалма уруктандыруу',
        description: 'Жылкыларды жасалма жол менен уруктандыруу боюнча маалыматтар',
        fullDescription: 'Жасалма уруктандыруу - бул жылкы чарбачылыгындагы заманбап технология. '
            'Бул бөлүмдө жасалма уруктандыруунун артыкчылыктары жана кемчиликтери, аны колдонуу '
            'техникасы жана зарыл болгон шарттар жөнүндө кеңири маалыматтар берилген.'
      ),
    ];

    return CategoryScreen(
      title: categoryTitle,
      bannerImagePath: bannerImagePath,
      bannerDescription: bannerDescription,
      topics: inseminationTopics,
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: Sizes.paddingL),
          child: AppLogo(),
        ),
      ],
    );
  }
}
