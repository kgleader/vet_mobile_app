// Бул файл колдонмо үчүн жалпы декорация (BoxDecoration, BorderRadius) функцияларын камтыйт жана темалык карточкаларды куруу методдорун аныктайт.
import 'package:flutter/material.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';

class AppDecorations {
  static BorderRadius cardBorderRadius = BorderRadius.circular(12.0);
  static BorderRadius largeCardImageBorderRadius = const BorderRadius.only(
    topLeft: Radius.circular(12.0),
    topRight: Radius.circular(12.0),
  );


  static BoxDecoration topicItemCardDecoration({required BuildContext context}) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: cardBorderRadius,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          spreadRadius: 0,
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  static BoxDecoration largeTopicCardDecoration({required BuildContext context}) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: cardBorderRadius,
      boxShadow: [
        BoxShadow(
          color: AppColors.grey.withOpacity(0.15),
          spreadRadius: 1,
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
      border: Border.all(
        color: Colors.green.shade600,
        width: 1.5,
      ),
    );
  }

  static BoxDecoration mainBannerCardDecoration({required BuildContext context}) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: cardBorderRadius,
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          spreadRadius: 0,
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  static Widget buildSmallTopicCard({
    required BuildContext context,
    required TopicListItemModel topic,
    required VoidCallback onTap,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: AppDecorations.topicItemCardDecoration(context: context),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppDecorations.cardBorderRadius,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(11.0),
                child: Image.asset(
                  topic.imagePath,
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 60, height: 60, color: AppColors.grey.withOpacity(0.1),
                    child: Icon(Icons.broken_image, size: 30, color: AppColors.grey),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.title,
                      style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    if (topic.description.isNotEmpty)
                      Text(
                        topic.description,
                        style: textTheme.bodySmall?.copyWith(color: AppColors.grey),
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
    );
  }

  static Widget buildLargeTopicCard({
    required BuildContext context,
    required TopicListItemModel topic,
    required VoidCallback onTap,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: AppDecorations.largeTopicCardDecoration(context: context),
      child: InkWell(
        onTap: onTap,
        borderRadius: AppDecorations.cardBorderRadius,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: AppDecorations.largeCardImageBorderRadius,
              child: Image.asset(
                topic.imagePath,
                width: double.infinity,
                height: 180,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 180,
                  width: double.infinity,
                  color: AppColors.grey.withOpacity(0.1),
                  child: Center(child: Icon(Icons.broken_image, size: 50, color: AppColors.grey)),
                ),
              ),
            ),
            if (topic.description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  topic.description,
                  style: textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
        ),
      ),
    );
  }
}