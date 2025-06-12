// Бул файл бодо малдын оорулары жана дарылоо маалыматын көрсөтүүчү экранды аныктайт.
// Экранда оорулар боюнча жалпы маалымат (баннер, сүрөттөмө) жана конкреттүү оору темаларынын тизмеси көрсөтүлөт.
// CategoryScreen виджетин колдонуп, контентти стандартташтырылган түрдө чагылдырат.
import 'package:flutter/material.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/core/app_logo.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/screens/menu/category_screen.dart';

class CattleDiseasesScreen extends StatelessWidget {
  const CattleDiseasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String categoryTitle = "Дарылоо"; // AppBar title from screenshot
    final String bannerImagePath = "assets/images/cattle_desease_banner.png"; // Your new banner
    // Banner description from the first screenshot (list view)
    final String bannerDescription = "Lorem Ipsum is simply dummy text of the printing";

    final List<TopicListItemModel> diseaseTopics = [
      TopicListItemModel(
        id: 'disease_1',
        title: "Дарылоо",
        description: "Lorem Ipsum is simply dummy text of the",
        imagePath: "assets/images/cattle_daaryloo_banner.png",
        fullDescription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard Lorem Ipsum is simply dummy text of the printing and type. Lorem Ipsum has been the industry's standard Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard"
                       "\n\nЖаңы абзац.\n\nДагы бир узун текст бул жерде. Бул текст жылдырууну текшерүү үчүн атайын кошулду. "
                       + "Көптөгөн саптарды кошуп, экрандан ашып кетээрин текшеребиз. " * 20 // Бул сапты 20 жолу кайталайт
      ),
      TopicListItemModel(
        id: 'disease_2',
        title: "Дарылоо",
        description: "Lorem Ipsum is simply dummy text of the",
        imagePath: "assets/images/cattle_ooru_topic2.png",
        fullDescription: "Бул жерде бодо малдын ЭКИНЧИ оорусу жана аны дарылоо боюнча толук маалымат берилет. " // Баштапкы текстти бир аз өзгөрттүм, айырмалоо үчүн
                       "Бул дагы ЭКИНЧИ тема үчүн кошумча узун текст. "
                       + "Жылдырууну текшерүү максатында бул саптар кошулду. "
                       + "Экранга батпай калышы үчүн дагы бир нече сап. " * 15 // Бул сапты 15 жолу кайталайт
      ),
      TopicListItemModel(
        id: 'disease_3',
        title: "Дарылоо",
        description: "Lorem Ipsum is simply dummy text of the",
        imagePath: "assets/images/cattle_ooru_topic3.png",
        fullDescription: "Бул жерде бодо малдын ҮЧҮНЧҮ оорусу жана аны дарылоо боюнча толук маалымат берилет. " // Айырмалоо үчүн өзгөртүлдү
                       "Бул ҮЧҮНЧҮ тема үчүн кошумча узун текст. "
                       + "Жылдырууну текшерүү максатында бул саптар дагы кошулду. "
                       + "Экранга батпай калышы үчүн дагы бир нече саптарды кошолу. " * 18 // Бул сапты 18 жолу кайталайт
      ),
    ];

    return CategoryScreen(
      title: categoryTitle,
      bannerImagePath: bannerImagePath,
      bannerDescription: bannerDescription,
      topics: diseaseTopics,
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: Sizes.paddingL),
          child: AppLogo(),
        ),
      ],
    );
  }
}