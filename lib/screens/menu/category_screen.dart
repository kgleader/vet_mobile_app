import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_logo.dart';
import 'package:vet_mobile_app/core/bottom_bar.dart'; 
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/widgets/custom_bottom_sheet.dart'; // ADDED: Import for custom bottom sheet

class _TopicListItem extends StatelessWidget {
  final TopicListItemModel item;
  final Function(String, {double? width, double? height, BoxFit? fit}) buildImage;

  const _TopicListItem({
    required this.item,
    required this.buildImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: Sizes.paddingL, vertical: Sizes.paddingS),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.borderRadius),
        ),
        child: InkWell(
          onTap: () {
            showCustomBottomSheet(
              context,
              title: item.title,
              content: Text(
                item.description, // Full description for the bottom sheet
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(Sizes.borderRadius),
          child: Padding(
            padding: const EdgeInsets.all(Sizes.paddingM),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.circular(Sizes.borderRadiusS),
                  child: buildImage(
                    item.imagePath,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: Sizes.spacingM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: Sizes.spacingS),
                      Text(
                        item.description, // Short description for the list item
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryScreen extends StatelessWidget {
  final String title; // AppBar аталышы
  final String bannerImagePath; // Негизги баннер сүрөтүнүн жолу
  final List<TopicListItemModel> topicItems; // Тема пункттарынын тизмеси

  const CategoryScreen({
    super.key,
    required this.title,
    required this.bannerImagePath, // REVERTED: Made required again
    required this.topicItems,
  });

  Widget _buildImage(String imagePath,
      {double? width, double? height, BoxFit? fit}) {
    if (imagePath.toLowerCase().endsWith('.svg')) {
      return SvgPicture.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit ?? BoxFit.contain,
      );
    } else {
      return Image.asset(
        imagePath,
        width: width,
        height: height,
        fit: fit,
      );
    }
  }

  Widget _buildHeaderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(Sizes.paddingL),
          child: Text(
            "Тема",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingL),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(Sizes.borderRadius),
            child: _buildImage(
              bannerImagePath, // Негизги баннер сүрөтү
              width: double.infinity,
              height: 180, // Бийиктигин тууралаңыз
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: Sizes.spacingM),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => context.pop(), // Же context.go(RouteNames.menu)
        ),
        title: Text(
          title,
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderSection(), // Extracted header and banner
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: topicItems.length,
              itemBuilder: (context, index) {
                final item = topicItems[index];
                return _TopicListItem(item: item, buildImage: _buildImage);
              },
            ),
            const SizedBox(height: Sizes.paddingL),
          ],
        ),
      ),
      bottomNavigationBar: const BottomBar(currentIndex: 1), // ADDED: BottomBar, assuming 'Menu' is index 1
    );
  }
}