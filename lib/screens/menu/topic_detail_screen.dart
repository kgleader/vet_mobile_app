// Бул файл тандалган теманын (мисалы, оору, тоют ж.б.) толук маалыматын көрсөтүүчү экранды аныктайт.
// Экранда теманын аталышы, сүрөтү (эгер бар болсо) жана толук сүрөттөмөсү көрсөтүлөт.
// Колдонуучу артка кайтуу баскычы аркылуу мурунку экранга кайта алат.
//
// Негизги колдонулган элементтер:
// - Виджеттер: TopicDetailScreen (StatelessWidget).
// - UI куруу: build() методу Scaffold, AppBar, теманын сүрөтү (Image.asset), аталышы (Text) жана толук сүрөттөмөсүн (Text) камтыйт.
// - Маалымат өткөрүү: Конструктор аркылуу TopicListItemModel объектиси жана bottomBarCurrentIndex кабыл алынат.
// - Навигация: GoRouter.of(context).pop() аркылуу артка кайтуу.
// - Макет виджеттери: Scaffold, AppBar, SingleChildScrollView, Padding, Column, ClipRRect, Image.asset, SizedBox, Text.
// - Стилдештирүү: Theme.of(context).textTheme (headlineSmall, bodyLarge), TextStyle, AppColors.
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/core/app_logo.dart';

class TopicDetailScreen extends StatelessWidget {
  final TopicListItemModel topic;
  final int bottomBarCurrentIndex;

  const TopicDetailScreen({
    super.key,
    required this.topic,
    required this.bottomBarCurrentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Мисалы
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary), // Мисалы
          onPressed: () => GoRouter.of(context).pop(),
        ),
        title: Text(
          topic.title, // Же "Тема" деп өзгөртсөңүз болот
          style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: Sizes.paddingL),
            child: AppLogo(), // <<<--- ТУУРА ЛОГОТИП УШУЛ ЖЕРДЕ БОЛУШУ КЕРЕК
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.paddingL),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (topic.imagePath.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
                  child: Image.asset(
                    topic.imagePath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              const SizedBox(height: Sizes.paddingM),
              Text(
                topic.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: Sizes.paddingM),
              Text(
                topic.fullDescription,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
