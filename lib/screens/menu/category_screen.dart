// Бул файл ар кандай категориялардагы темаларды (мисалы, оорулар, тоюттандыруу) бирдиктүү стилде көрсөтүү үчүн жалпыланган экранды (CategoryScreen) аныктайт.
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_decorations.dart'; // Бул импорт бар экенин текшериңиз
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/widgets/custom_topic_item.dart'; // Импорттоо

class CategoryScreen extends StatelessWidget {
  final String title;
  final String bannerImagePath;
  final String? bannerDescription;
  final List<TopicListItemModel> topics;
  final List<Widget>? actions; // New parameter for additional actions

  const CategoryScreen({
    super.key,
    required this.title,
    required this.bannerImagePath,
    this.bannerDescription,
    required this.topics,
    this.actions, // Initialize the new parameter
  });

  Widget _buildHeaderSection(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: AppDecorations.mainBannerCardDecoration(context: context), // <--- ӨЗГӨРТҮЛДҮ
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Image
          SizedBox(
            height: 150, // Фигмадагы баннердин бийиктиги
            width: double.infinity,
            child: bannerImagePath.toLowerCase().endsWith('.svg')
                ? SvgPicture.asset(
                    bannerImagePath,
                    fit: BoxFit.cover, // Фигмадагыдай
                    placeholderBuilder: (BuildContext context) => Container(
                      color: Colors.grey[300],
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  )
                : Image.asset(
                    bannerImagePath,
                    fit: BoxFit.cover, // Фигмадагыдай
                    cacheHeight: (150 * MediaQuery.of(context).devicePixelRatio).round(),
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[300],
                      child: const Center(child: Icon(Icons.error)),
                    ),
                  ),
          ),
          // Banner Description Text (if it exists)
          if (bannerDescription != null && bannerDescription!.isNotEmpty) ...[
            Padding(
              // Фигмадагы баннер текстинин ички боштуктары
              padding: const EdgeInsets.all(Sizes.paddingM), // Же Sizes.paddingL, Фигмага жараша
              child: Text(
                bannerDescription!,
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary), // Фигмадагыдай стиль
              ),
            ),
          ],
        ],
      ),
    );
  }

  // Бул CategoryScreen классынын ичинде же өзүнчө функция болушу мүмкүн
  Widget _buildTopicListItem(BuildContext context, TopicListItemModel topic) {
    return CustomTopicItem( // Бул жер өзгөрүүсүз, CustomTopicItem өзү оңдолду
      imagePath: topic.imagePath,
      title: topic.title,
      description: topic.description,
      onTap: () {
        GoRouter.of(context).pushNamed(
          RouteNames.topicDetail,
          extra: {'topic': topic, 'currentIndex': 0},
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Added background color for consistency
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => GoRouter.of(context).pop(), // Navigate to main menu
        ),
        title: Text(
          title, // Category title
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: actions, // Используем переданные actions
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(Sizes.paddingL),
            child: _buildHeaderSection(context),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingL),
              itemCount: topics.length,
              itemBuilder: (context, index) {
                final topic = topics[index];
                return _buildTopicListItem(context, topic);
              },
            ),
          ),
        ],
      ),
      // bottomNavigationBar: const BottomBar( // Removed as MainLayout provides it
      //   currentIndex: 1,
      // ),
    );
  }
}