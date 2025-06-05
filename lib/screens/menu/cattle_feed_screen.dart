// filepath: lib/screens/menu/cattle_feed_screen.dart
import 'package:flutter/material.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/core/app_logo.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/screens/menu/category_screen.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data specific to the "Тоют" (Feed) category
    final String categoryTitle = "Тоют"; // AppBar title
    final String bannerImagePath = "assets/images/grass_banner.jpg"; // Main banner for Feed
    final String bannerDescription = "Lorem Ipsum is simply dummy text of the"; // Text on the banner

    final List<TopicListItemModel> feedTopics = [
      TopicListItemModel(
        id: 'feed_1',
        title: "Тоют", // Эгер скриншоттогудай "Тема" кылып өзгөрткүңүз келсе, бул жерди да оңдоңуз
        description: "Lorem Ipsum is simply dummy text of the",
        imagePath: "assets/images/feed_topic1.jpg", // Скриншоттогу сүрөткө алмаштырыңыз, мисалы: "assets/images/cows_in_barn.jpg"
        fullDescription: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard Lorem Ipsum is simply dummy text of the printin has been the industry's standard Lorem Ipsum is simply dummy text of the printing and typesetvting industry. Lorem Ipsum has been the industry's standard printing and typesetvting indus"
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