import 'package:flutter/material.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart'; // AppBar actions үчүн
import 'package:vet_mobile_app/core/app_logo.dart';      // AppBar actions үчүн
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/screens/menu/category_screen.dart'; // CategoryScreen'ди импорттойбуз

class InseminationScreen extends StatelessWidget {
  const InseminationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String categoryTitle = "Уруктандыруу";
    // Баннердин сүрөтүнүн туура жолун жана чыныгы сүрөттөмөсүн коюңуз
    final String bannerImagePath = "assets/images/muzoo_banner.png"; // Мисалы, туура жолду коюңуз
    final String bannerDescription = "Малды жасалма жол менен уруктандыруунун негиздери жана артыкчылыктары."; // Маанилүү сүрөттөмө

    // Уруктандыруу темаларынын тизмесин түзүңүз
    final List<TopicListItemModel> inseminationTopics = [
      TopicListItemModel(
        id: 'insemination_topic_1',
        title: "Уйларды уруктандыруу",
        description: "Уйларды жасалма уруктандыруунун өзгөчөлүктөрү жана ыкмалары.",
        imagePath: "assets/images/insemination1.png", // Туура сүрөт жолун коюңуз
        fullDescription: "Уйларды жасалма уруктандыруу боюнча толук маалымат. "
                       "Бул бөлүмдө уйлардын жыныстык цикли, уруктандыруу үчүн оптималдуу убакытты аныктоо, "
                       + "урукту сактоо жана колдонуу эрежелери, ошондой эле процедуранын өзү кеңири баяндалат. "
                       + "Экономикалык жактан натыйжалуулугу жана тукумдун сапатын жакшыртуудагы ролу. "
                       + "Бул текст жылдырууну текшерүү үчүн атайын узартылды. " * 10
                       + "\n\nКошумча кеңештер жана эскертүүлөр. "
                       + "Practice makes perfect. " * 8
      ),
      TopicListItemModel(
        id: 'insemination_topic_2',
        title: "Койлорду уруктандыруу",
        description: "Койлорду жасалма уруктандыруунун негизги аспекттери.",
        imagePath: "assets/images/insemination2.png", // Туура сүрөт жолун коюңуз
        fullDescription: "Койлорду жасалма уруктандыруу технологиясы. "
                       "Бул жерде койлордун физиологиялык өзгөчөлүктөрүн эске алуу менен уруктандыруу процесси, "
                       + "колдонулуучу аспаптар жана уруктун сапатына коюлуучу талаптар жөнүндө маалымат берилет. "
                       + "Майда малды уруктандыруунун артыкчылыктары жана мүмкүн болгон кыйынчылыктар. "
                       + "Бул текст дагы жылдырууну камсыз кылуу максатында узартылды. " * 11
                       + "\n\nИйгиликтүү уруктандыруу үчүн маанилүү факторлор. "
                       + "A stitch in time saves nine. " * 9
      ),
      TopicListItemModel(
        id: 'insemination_topic_3',
        title: "Жылкыларды уруктандыруу",
        description: "Жылкыларды жасалма уруктандыруу жана анын мааниси.",
        imagePath: "assets/images/insemination3.png", // Туура сүрөт жолун коюңуз
        fullDescription: "Жылкыларды жасалма уруктандыруунун заманбап ыкмалары. "
                       "Бээлердин жыныстык циклин көзөмөлдөө, урукту алуу, баалоо, суюлтуу жана сактоо. "
                       + "Уруктандыруу техникалары жана процедурадан кийинки байкоо. "
                       + "Асыл тукум жылкы чарбасында жасалма уруктандыруунун ролу. "
                       + "Экранга батпай, жылдырууга мүмкүнчүлүк түзүү үчүн бул текст да атайылап узартылды. " * 10
                       + "\n\nВетеринардык көзөмөлдүн маанилүүлүгү. "
                       + "Knowledge is power. " * 8
      ),
      // Керек болсо дагы темаларды кошобуз
    ];

    return CategoryScreen(
      title: categoryTitle,
      bannerImagePath: bannerImagePath,
      bannerDescription: bannerDescription,
      topics: inseminationTopics,
      actions: const [ // AppBar'га AppLogo кошуу (CategoryScreen'де бар болсо да, бул жерде да калтырсаңыз болот)
        Padding(
          padding: EdgeInsets.only(right: Sizes.paddingL),
          child: AppLogo(),
        ),
      ],
    );
  }
}