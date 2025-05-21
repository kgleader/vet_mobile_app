import 'package:flutter/material.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/screens/menu/category_screen.dart';

class FeedScreen extends StatelessWidget { // Renamed class
  const FeedScreen({super.key}); // Renamed constructor

  @override
  Widget build(BuildContext context) {
    // Data specific to the "Тоют" (Feed) category
    final String categoryTitle = "Тоют"; // AppBar title
    final String bannerImagePath = "assets/images/grass_banner.jpg"; // Main banner for Feed - UPDATED to JPG
    final String bannerDescription = "Lorem Ipsum is simply dummy text of the"; // Text on the banner, updated to match Figma

    final List<TopicListItemModel> feedTopics = [
      TopicListItemModel(
        id: 'feed_1',
        title: "Тоют", // Updated to match Figma
        description: "Lorem Ipsum is simply dummy text of the", // Updated to match Figma
        imagePath: "assets/images/feed_topic1.jpg", // Confirm this path
        fullDescription: "Бул жерде тоюттун биринчи темасы боюнча толук маалымат берилет. Мал чарбасында колдонулган негизги тоют түрлөрү, алардын аш болумдуулугу жана малдын ден соолугуна тийгизген таасири жөнүндө сөз болот."
      ),
      TopicListItemModel(
        id: 'feed_2',
        title: "Тоют", // Updated to match Figma
        description: "Lorem Ipsum is simply dummy text of the", // Updated to match Figma
        imagePath: "assets/images/feed_topic2.jpg", // Confirm this path
        fullDescription: "Экинчи темада тоюттандыруунун ар кандай ыкмалары жана рацион түзүү эрежелери каралат. Малдын жашына, породасына жана физиологиялык абалына жараша тоюттандыруунун өзгөчөлүктөрү баяндалат."
      ),
      TopicListItemModel(
        id: 'feed_3',
        title: "Тоют", // Updated to match Figma
        description: "Lorem Ipsum is simply dummy text of the", // Updated to match Figma
        imagePath: "assets/images/feed_topic3.jpg", // Confirm this path
        fullDescription: "Үчүнчү тема тоют коопсуздугуна жана сапатына арналат. Тоютту сактоо, даярдоо жана анын сапатын көзөмөлдөө боюнча практикалык кеңештер берилет. Ошондой эле, тоют аркылуу жугуучу оорулардын алдын алуу маселелери камтылат."
      ),
    ];

    return CategoryScreen(
      title: categoryTitle,
      bannerImagePath: bannerImagePath,
      bannerDescription: bannerDescription,
      topics: feedTopics, // "topics" колдонулат, "topicItems" эмес
    );
  }
}
