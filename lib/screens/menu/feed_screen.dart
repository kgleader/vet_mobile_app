// Бул файл "Тоют" категориясына тиешелүү экранды аныктайт.
// Экранда тоют боюнча жалпы маалымат (баннер, сүрөттөмө) жана тиешелүү темалардын тизмеси көрсөтүлөт.
// Бул экран CategoryScreen виджетин колдонуп, контентти стандартташтырылган түрдө чагылдырат.
//
// Негизги колдонулган элементтер:
// - Виджеттер: FeedScreen (StatelessWidget).
// - UI куруу: build() методу CategoryScreen виджетине керектүү маалыматтарды (аталышы, баннердин сүрөтү, сүрөттөмөсү, темалар тизмеси) өткөрүп берет.
// - Маалымат модели: TopicListItemModel ар бир тоют темасы үчүн колдонулат.
// - Жалпы виджеттер: CategoryScreen (кайра колдонулуучу), AppLogo.
import 'package:flutter/material.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/core/app_logo.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/screens/menu/category_screen.dart';

class FeedScreen extends StatelessWidget { 
  const FeedScreen({super.key}); 

  @override
  Widget build(BuildContext context) {
    final String categoryTitle = "Тоют"; 
    final String bannerImagePath = "assets/images/grass_banner.jpg"; 
    final String bannerDescription = "Lorem Ipsum is simply dummy text of the"; 

    final List<TopicListItemModel> feedTopics = [
      TopicListItemModel(
        id: 'feed_1',
        title: "Тоют", 
        description: "Lorem Ipsum is simply dummy text of the", 
        imagePath: "assets/images/feed_topic1.jpg", 
        fullDescription: "Бул жерде тоюттун биринчи темасы боюнча толук маалымат берилет. Мал чарбасында колдонулган негизги тоют түрлөрү, алардын аш болумдуулугу жана малдын ден соолугуна тийгизген таасири жөнүндө сөз болот."
      ),
      TopicListItemModel(
        id: 'feed_2',
        title: "Тоют", 
        description: "Lorem Ipsum is simply dummy text of the", 
        imagePath: "assets/images/feed_topic2.jpg", 
        fullDescription: "Экинчи темада тоюттандыруунун ар кандай ыкмалары жана рацион түзүү эрежелери каралат. Малдын жашына, породасына жана физиологиялык абалына жараша тоюттандыруунун өзгөчөлүктөрү баяндалат."
      ),
      TopicListItemModel(
        id: 'feed_3',
        title: "Тоют", 
        description: "Lorem Ipsum is simply dummy text of the", 
        imagePath: "assets/images/feed_topic3.jpg", 
        fullDescription: "Үчүнчү тема тоют коопсуздугуна жана сапатына арналат. Тоютту сактоо, даярдоо жана анын сапатын көзөмөлдөө боюнча практикалык кеңештер берилет. Ошондой эле, тоют аркылуу жугуучу оорулардын алдын алуу маселелери камтылат."
      ),
    ];

    return CategoryScreen(
      title: categoryTitle,
      bannerImagePath: bannerImagePath,
      bannerDescription: bannerDescription,
      topics: feedTopics, 
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: Sizes.paddingL),
          child: AppLogo(),  
        ),
      ],
    );
  }
}
