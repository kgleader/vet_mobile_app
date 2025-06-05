import 'package:flutter/material.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart'; // Керек болушу мүмкүн, эгер CategoryScreen колдонбосоңуз
import 'package:vet_mobile_app/core/app_logo.dart'; // AppBar'дагы actions үчүн
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/screens/menu/category_screen.dart';

class ChickenFeedingScreen extends StatelessWidget {
  const ChickenFeedingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String categoryTitle = "Тоют";
    final String bannerImagePath = "assets/images/chicken_feed_banner.png"; // Туура жолду коюңуз
    final String bannerDescription = "Тоокторду туура тоюттандыруу боюнча негизги маалыматтар жана кеңештер."; // Маанилүү сүрөттөмө

    final List<TopicListItemModel> feedingTopics = [
      TopicListItemModel(
        id: 'chicken_feed_topic_1',
        title: "Негизги тоюттар",
        description: "Тооктор үчүн негизги тоюттардын түрлөрү жана өзгөчөлүктөрү.",
        imagePath: "assets/images/chicken_topic1.png", // ӨЗГӨРТҮҢҮЗ
        fullDescription: "Биринчи тоют темасы боюнча абдан кенен маалымат. Бул жерде тоокторду тоюттандыруунун негизги принциптери, керектүү азык заттар, витаминдер жана минералдар жөнүндө сөз болот. "
                       "Ошондой эле, ар кандай курактагы тооктор үчүн рацион түзүүнүн өзгөчөлүктөрү каралат. "
                       + "Бул текст жылдырууну текшерүү үчүн атайын узартылды. " * 10 // Кайталоону азайтсаңыз болот, эгер TopicDetailScreen'де мазмун жетиштүү болсо
                       + "\n\nЖаңы абзац.\n\nДагы бир узун текст бул жерде. "
                       + "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard. " * 8
      ),
      TopicListItemModel(
        id: 'chicken_feed_topic_2',
        title: "Кошумча тоюттар",
        description: "Витаминдер, минералдар жана башка кошумчалар.",
        imagePath: "assets/images/chicken_topic2.png", // ӨЗГӨРТҮҢҮЗ
        fullDescription: "Экинчи тоют темасы: тооктор үчүн даяр тоюттар жана алардын түрлөрү. Бул бөлүмдө базардагы ар кандай даяр тоюттардын курамы, артыкчылыктары жана кемчиликтери талкууланат. "
                       "Туура тоютту кантип тандоо керектиги боюнча кеңештер берилет. "
                       + "Бул текст дагы жылдырууну камсыз кылуу максатында узартылды. " * 11
                       + "\n\nКошумча маалыматтар үчүн дагы бир абзац. "
                       + "The quick brown fox jumps over the lazy dog. " * 9
      ),
      TopicListItemModel(
        id: 'chicken_feed_topic_3',
        title: "Үй шартында тоют даярдоо",
        description: "Өз алдынча тоют аралашмаларын даярдоо ыкмалары.",
        imagePath: "assets/images/chicken_topic3.png", // ӨЗГӨРТҮҢҮЗ
        fullDescription: "Үчүнчү тоют темасы: үй шартында тоют даярдоо. Бул жерде өз алдынча тоют аралашмаларын даярдоонун рецепттери жана ыкмалары келтирилет. "
                       "Кайсы ингредиенттерди колдонуу керектиги жана алардын пропорциялары жөнүндө маалымат берилет. "
                       + "Экранга батпай, жылдырууга мүмкүнчүлүк түзүү үчүн бул текст да атайылап узартылды. " * 10
                       + "\n\nАкыркы абзац, дагы бир аз текст. "
                       + "Many hands make light work. " * 8
      ),
    ];

    return CategoryScreen(
      title: categoryTitle,
      bannerImagePath: bannerImagePath,
      bannerDescription: bannerDescription,
      topics: feedingTopics,
      actions: const [ // AppBar'га AppLogo кошуу
        Padding(
          padding: EdgeInsets.only(right: Sizes.paddingL),
          child: AppLogo(),
        ),
      ],
    );
  }
}
