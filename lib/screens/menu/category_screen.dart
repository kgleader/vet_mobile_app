import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_logo.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/core/bottom_bar.dart'; // Added BottomBar import
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';

class CategoryScreen extends StatelessWidget {
  final String title;
  final String bannerImagePath;
  final String? bannerDescription;
  final List<TopicListItemModel> topics;

  const CategoryScreen({
    super.key,
    required this.title,
    required this.bannerImagePath,
    this.bannerDescription,
    required this.topics,
  });

  Widget _buildHeaderSection(BuildContext context) {
    return Container( // This is the card container
      width: double.infinity,
      // NO internal padding here; padding for the card itself is handled by the parent Padding widget in CategoryScreen.build
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.5),
          width: 1.0,
        ),
      ),
      clipBehavior: Clip.antiAlias, // Ensures children are clipped to the borderRadius
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner Image
          SizedBox(
            height: 150, // Adjust height as needed
            width: double.infinity, // Takes full width of the card
            child: bannerImagePath.toLowerCase().endsWith('.svg')
                ? SvgPicture.asset(
                    bannerImagePath,
                    fit: BoxFit.cover,
                    placeholderBuilder: (BuildContext context) => Container(
                      color: Colors.grey[300],
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                  )
                : Image.asset(
                    bannerImagePath,
                    fit: BoxFit.cover,
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
              padding: const EdgeInsets.all(Sizes.paddingM), // Padding for the text within the card
              child: Text(
                bannerDescription!,
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary),
              ),
            ),
          ],
        ],
      ),
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
          onPressed: () => context.go(RouteNames.menu), // Navigate to main menu
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
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: Sizes.paddingL),
            child: AppLogo(),
          ),
        ],
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
                return _TopicListItem(
                  topic: topic,
                  // Pass the current menu index for the bottom bar when navigating to topic detail
                  // Assuming 'Menu' tab is index 1
                  currentBottomBarIndexForDetail: 1,
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(
        // Assuming the "Menu" tab (where these categories are listed) is index 1
        currentIndex: 1,
      ),
    );
  }
}

class _TopicListItem extends StatelessWidget {
  final TopicListItemModel topic;
  final int currentBottomBarIndexForDetail;

  const _TopicListItem({
    required this.topic,
    required this.currentBottomBarIndexForDetail,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white, // Ensure card background is white
      margin: const EdgeInsets.only(bottom: Sizes.spacingM),
      elevation: 0, // Remove shadow, rely on border
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
        side: BorderSide(color: AppColors.primary.withOpacity(0.5), width: 1.0), // Add border
      ),
      child: InkWell(
        onTap: () {
          context.pushNamed(
            RouteNames.topicDetail,
            extra: {
              'topic': topic,
              'currentIndex': currentBottomBarIndexForDetail,
            },
          );
        },
        borderRadius: BorderRadius.circular(Sizes.borderRadius),
        child: Padding(
          padding: const EdgeInsets.all(Sizes.paddingM),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                height: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(Sizes.borderRadiusS),
                  child: topic.imagePath.toLowerCase().endsWith('.svg')
                      ? SvgPicture.asset(
                          topic.imagePath,
                          fit: BoxFit.cover,
                          placeholderBuilder: (BuildContext context) => Container(
                            color: Colors.grey[200],
                            child: const Icon(Icons.image, color: Colors.grey),
                          ),
                        )
                      : Image.asset(
                          topic.imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: Colors.grey[200],
                            child: const Icon(Icons.error, color: Colors.grey),
                          ),
                        ),
                ),
              ),
              const SizedBox(width: Sizes.spacingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.title,
                      style: AppTextStyles.titleSmall.copyWith(color: AppColors.textPrimary),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: Sizes.spacingS),
                    Text(
                      topic.description,
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: AppColors.primary, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}