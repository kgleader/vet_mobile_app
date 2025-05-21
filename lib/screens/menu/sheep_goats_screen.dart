import 'package:flutter/material.dart';

import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/screens/menu/category_screen.dart';

class SheepGoatsScreen extends StatelessWidget {
  const SheepGoatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String categoryTitle = "Кой эчки";
    final String bannerImagePath = "assets/images/sheep_banner.png";
    final String bannerDescription = "Кой жана эчки чарбасы, аларды багуу жана продукция алуу.";

    final List<TopicListItemModel> topics = [
      TopicListItemModel(
        id: 'sheep_topic_1',
        imagePath: 'assets/images/sheep_topic1.png',
        title: 'Породалары',
        description: 'Кой-эчкилердин популярдуу породалары жана аларды тандоо.',
        fullDescription: 'Кыргызстанда жана дүйнөдө кеңири таралган кой жана эчки породалары (мисалы, меринос, алай, романов койлору; заанен, нубия эчкилери) жөнүндө маалымат. Ар бир породанын эт, жүн, сүт багытындагы продуктуулук көрсөткүчтөрү, климаттык шарттарга ыңгайлуулугу, ооруларга туруктуулугу жана чарбалык мааниси боюнча кеңири баяндама. Чарбанын максатына жараша порода тандоо боюнча сунуштар.'
      ),
      TopicListItemModel(
        id: 'sheep_topic_2',
        imagePath: 'assets/images/sheep_topic2.png',
        title: 'Багуу жана кармоо',
        description: 'Кой-эчкилерди багуунун өзгөчөлүктөрү, жайыт жана тоюттандыруу.',
        fullDescription: 'Кой жана эчкилерди багуунун жана кармоонун негизги аспектилери. Алар үчүн ыңгайлуу короо-сарайларды куруу, жайыттарды туура пайдалануу жана которуштуруу, суу менен камсыздоо. Жыл мезгилдерине жараша тоюттандыруу рациондорун түзүү (жайкы жайыт, кышкы тоют – чөп, сенаж, силос, концентраттар). Козуларды жана улактарды багуу, кыркым алуу, туягын тазалоо сыяктуу маанилүү зоотехникалык иш-чаралар.'
      ),
      TopicListItemModel(
        id: 'sheep_topic_3',
        imagePath: 'assets/images/sheep_topic3.png',
        title: 'Продукциясы',
        description: 'Кой-эчкиден алынуучу продукциялар: эт, жүн, сүт.',
        fullDescription: 'Кой жана эчки чарбасынан алынуучу негизги продукциялар жана алардын сапаттык көрсөткүчтөрү. Эт (козу эти, эчки эти), жүн (меринос жүнү, кылчык жүн), сүт (эчки сүтү жана андан жасалган азыктар – быштак, сыр) жана кошумча продукциялар (тери, мүйүз). Продукцияны алгачкы иштетүү, сактоо жана сатууга даярдоо боюнча маалыматтар. Рыноктогу баалар жана продукциянын атаандаштыкка жөндөмдүүлүгүн арттыруу жолдору.'
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
