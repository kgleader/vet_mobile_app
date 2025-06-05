import 'package:flutter/material.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/core/app_logo.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/screens/menu/category_screen.dart';

class ChickenDiseasesScreen extends StatelessWidget {
  const ChickenDiseasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String categoryTitle = "Дарылоо";
    final String bannerImagePath = "assets/images/chicken_ooru_banner.png";
    final String bannerDescription = "Lorem Ipsum is simply dummy text of the printing";

    final List<TopicListItemModel> diseaseTopics = [
      TopicListItemModel(
        id: 'chicken_disease_1',
        title: "Дарылоо",
        description: "Lorem Ipsum is simply dummy text of the",
        imagePath: "assets/images/chicken_ooru_topic1.png",
        fullDescription: "Биринчи тоок оорусу: Ньюкасл оорусу. Бул өтө жугуштуу вирустук оору, тооктордун дем алуу, нерв жана тамак сиңирүү системаларына зыян келтирет. "
                       "Негизги белгилери: чүчкүрүү, жөтөлүү, дем алуунун кыйындашы, шал болуу, ич өтүү. "
                       + "Дарылоо: спецификалык дарылоо жок, бирок экинчилик инфекцияларды алдын алуу үчүн антибиотиктер колдонулушу мүмкүн. Эң негизгиси – алдын алуу жана вакцинация. "
                       + "Бул текст жылдырууну текшерүү үчүн атайын узартылды. " * 18 // Бул сапты 18 жолу кайталайт
                       + "\n\nПрофилактика чаралары:\n - Вакцинация\n - Карантин\n - Биологиялык коопсуздук эрежелерин сактоо. "
                       + "Lorem Ipsum is simply dummy text of the printing and typesetting industry. " * 12
      ),
      TopicListItemModel(
        id: 'chicken_disease_2',
        title: "Дарылоо",
        description: "Lorem Ipsum is simply dummy text of the",
        imagePath: "assets/images/chicken_ooru_topic2.png",
        fullDescription: "Экинчи тоок оорусу: Кокцидиоз. Бул мите курттар (кокцидиялар) козгогон ичеги-карын оорусу, көбүнчө жаш тооктордо кездешет. "
                       "Белгилери: кан аралаш ич өтүү, алсыздык, өсүүдөн артта калуу, жем жебөө. "
                       + "Дарылоо: кокцидиостатиктер (сульфаниламиддер, ампролиум ж.б.) менен дарыланат. Дарылоо курсу ветеринар тарабынан белгиленет. "
                       + "Бул текст дагы жылдырууну камсыз кылуу максатында узартылды. " * 20 // Бул сапты 20 жолу кайталайт
                       + "\n\nАлдын алуу чаралары:\n - Тазалыкты сактоо\n - Тоютка кокцидиостатиктерди кошуу\n - Жаш тоокторду өзүнчө багуу. "
                       + "The quick brown fox jumps over the lazy dog. " * 15
      ),
      TopicListItemModel(
        id: 'chicken_disease_3',
        title: "Профилактика",
        description: "Lorem Ipsum is simply dummy text of the",
        imagePath: "assets/images/chicken_ooru_topic3.png",
        fullDescription: "Үчүнчү тоок оорусу: Сасык тумоо (Инфекциялык бронхит). Бул дагы вирустук оору, негизинен дем алуу жолдорун жабыркатат, бирок жумуртка тууган тооктордун репродуктивдик системасына да таасир этиши мүмкүн. "
                       "Белгилери: жөтөл, чүчкүрүү, көзүнөн жана мурдунан суу агуу, жумуртканын сапатынын төмөндөшү. "
                       + "Дарылоо: вируска каршы түз дарылоо жок. Экинчилик бактериялык инфекцияларды дарылоо үчүн антибиотиктер колдонулат. Вакцинация маанилүү. "
                       + "Экранга батпай, жылдырууга мүмкүнчүлүк түзүү үчүн бул текст да атайылап узартылды. " * 19 // Бул сапты 19 жолу кайталайт
                       + "\n\nМаанилүү эскертүү: Ар кандай оорунун белгилери байкалганда, тезинен ветеринардык адиске кайрылуу зарыл. "
                       + "Many hands make light work. " * 16
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
