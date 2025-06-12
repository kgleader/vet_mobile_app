// Бул файл "Оорулар" категориясына тиешелүү жалпы экранды аныктайт.
// Экранда малдын оорулары боюнча жалпы маалымат (баннер, сүрөттөмө) жана негизги оорулардын топтору (мисалы, жугуштуу, мите курт, зат алмашуу) темалар тизмеси түрүндө көрсөтүлөт.
// Бул экран CategoryScreen виджетин колдонуп, контентти стандартташтырылган түрдө чагылдырат.
//
// Негизги колдонулган элементтер:
// - Виджеттер: DiseasesScreen (StatelessWidget).
// - UI куруу: build() методу CategoryScreen виджетине керектүү маалыматтарды (аталышы, баннердин сүрөтү, сүрөттөмөсү, темалар тизмеси) өткөрүп берет.
// - Маалымат модели: TopicListItemModel ар бир оору темасы үчүн колдонулат.
// - Жалпы виджеттер: CategoryScreen (кайра колдонулуучу), AppLogo.
import 'package:flutter/material.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/core/app_logo.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/screens/menu/category_screen.dart'; 

class DiseasesScreen extends StatelessWidget {
  final int bottomBarCurrentIndex; 

  const DiseasesScreen({super.key, this.bottomBarCurrentIndex = 0});

  @override
  Widget build(BuildContext context) {
    final String categoryTitle = "Оорулар"; // Экрандын аталышы
    // Баннердин сүрөтүнүн туура жолун жана чыныгы сүрөттөмөсүн коюңуз
    final String bannerImagePath = "assets/images/grass_banner.jpg"; // Учурдагы баннер сүрөтүңүз
    final String bannerDescription = "Малдын негизги оорулары, аларды алдын алуу жана дарылоо жолдору боюнча маалыматтар."; // Маанилүү сүрөттөмө

    final List<TopicListItemModel> diseaseTopics = [
      TopicListItemModel(
        id: 'disease_topic_1',
        imagePath: 'assets/images/disease_topic1.jpg', // Туура сүрөт жолу
        title: 'Жугуштуу оорулар', // Теманын аталышын тактаңыз
        description: 'Малдын жугуштуу оорулары, белгилери жана дарылоо.', // Кыскача сүрөттөмө
        fullDescription: 'Бул бөлүмдө малдын жугуштуу оорулары, алардын негизги белгилери, диагностикалоо ыкмалары жана заманбап дарылоо жолдору жөнүндө кеңири маалымат берилет. Ошондой эле, оорулардын алдын алуу жана чарбада эпизоотиялык кырдаалды көзөмөлдөө боюнча сунуштар камтылган.'
      ),
      TopicListItemModel(
        id: 'disease_topic_2',
        imagePath: 'assets/images/disease_topic2.jpg', // Туура сүрөт жолу
        title: 'Мите курт оорулары', // Теманын аталышын тактаңыз
        description: 'Гельминтоздор, аларды аныктоо жана алдын алуу.', // Кыскача сүрөттөмө
        fullDescription: 'Малдын мите курттардан пайда болуучу оорулары (гельминтоздор) жана алардын экономикалык зыяны тууралуу маалымат. Гельминтоздордун түрлөрү, аларды аныктоо, дарылоо жана алдын алуу боюнча комплекстүү чаралар, дегельминтизациялоо схемалары келтирилген.'
      ),
      TopicListItemModel(
        id: 'disease_topic_3',
        imagePath: 'assets/images/disease_topic3.jpg', // Туура сүрөт жолу
        title: 'Зат алмашуу оорулары', // Теманын аталышын тактаңыз
        description: 'Зат алмашуунун бузулушунан келип чыккан оорулар.', // Кыскача сүрөттөмө
        fullDescription: 'Малдын зат алмашуу процесстеринин бузулушунан келип чыккан оорулар (мисалы, кетоз, остеодистрофия ж.б.) жана алардын себептери. Бул оорулардын клиникалык белгилери, диагностикасы, дарылоо принциптери жана тоюттандырууну оптималдаштыруу аркылуу алдын алуу жолдору баяндалат.'
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