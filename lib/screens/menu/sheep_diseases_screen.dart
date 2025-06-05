import 'package:flutter/material.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/core/app_logo.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/screens/menu/category_screen.dart';

class SheepDiseasesScreen extends StatelessWidget {
  final int bottomBarCurrentIndex;

  const SheepDiseasesScreen({super.key, this.bottomBarCurrentIndex = 0});

  @override
  Widget build(BuildContext context) {
    const String categoryTitle = "Дарылоо"; // Экрандын аталышы Фигмадагыдай

    // Фигмадагы баннер сүрөтү жана сүрөттөмөсү
    final String bannerImagePath = 'assets/images/sheep_drug_banner.png'; // Фигмадагы дары-дармектердин сүрөтүнүн жолу
    final String bannerDescription = "Lorem Ipsum is simply dummy text of the printing"; // Фигмадагы баннердин астындагы текст

    final List<TopicListItemModel> diseaseTopics = [
      TopicListItemModel(
        id: 'daryloo_topic_1',
        imagePath: 'assets/images/sheep_topic1.png', // Фигмадагы биринчи теманын сүрөтү (эки кой)
        title: 'Дарылоо', // Фигмадагы теманын аталышы
        description: 'Lorem Ipsum is simply dummy text of the', // Фигмадагы теманын кыскача сүрөттөмөсү
        fullDescription: 'Бул жерде биринчи теманын толук сүрөттөмөсү жайгашат. ${'Бул текст жылдырууну текшерүү үчүн атайын узартылды. ' * 15} Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
      ),
      TopicListItemModel(
        id: 'daryloo_topic_2',
        imagePath: 'assets/images/sheep_topic2.png', // Фигмадагы экинчи теманын сүрөтү (ноутбук)
        title: 'Дарылоо', // Фигмадагы теманын аталышы
        description: 'Lorem Ipsum is simply dummy text of the', // Фигмадагы теманын кыскача сүрөттөмөсү
        fullDescription: 'Экинчи теманын толук сүрөттөмөсү. ${'Бул текст жылдырууну текшерүү үчүн атайын узартылды. ' * 18} Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem.'
      ),
      TopicListItemModel(
        id: 'daryloo_topic_3',
        imagePath: 'assets/images/sheep_topic3.png', // Фигмадагы үчүнчү теманын сүрөтү (лаборатория)
        title: 'Дарылоо', // Фигмадагы теманын аталышы
        description: 'Lorem Ipsum is simply dummy text of the', // Фигмадагы теманын кыскача сүрөттөмөсү
        fullDescription: 'Үчүнчү тема боюнча кеңири маалымат. ${'Бул текст жылдырууну текшерүү үчүн атайын узартылды. ' * 20} At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus.'
      ),
      // Керек болсо, дагы темаларды кошсоңуз болот
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
