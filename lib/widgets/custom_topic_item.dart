import 'package:flutter/material.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_decorations.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';

class CustomTopicItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;
  final VoidCallback? onTap;

  const CustomTopicItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const double imageSize = 50.0;

    return Container(
      margin: const EdgeInsets.only(bottom: Sizes.paddingM),
      decoration: AppDecorations.topicItemCardDecoration(context: context),
      child: InkWell(
        borderRadius: AppDecorations.cardBorderRadius,
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.paddingM),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(imageSize / 2 - 4),
                child: Image.asset(
                  imagePath,
                  width: imageSize,
                  height: imageSize,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: imageSize,
                      height: imageSize,
                      decoration: BoxDecoration(
                        color: AppColors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(imageSize / 2 - 4),
                      ),
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: AppColors.grey.withOpacity(0.5),
                        size: imageSize * 0.6,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: Sizes.paddingM),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.titleSmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: Sizes.paddingXS),
                    Text(
                      description,
                      style: AppTextStyles.bodySmall.copyWith(
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
    );
  }
}