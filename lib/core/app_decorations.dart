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
      color: Colors.white, // Фигмада картанын фону ак
      borderRadius: cardBorderRadius, // Бурчтары тегеректелген бойдон калсын
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25), // 0.25 - бул 25% тунуктук. Керек болсо көбөйтүңүз.
          spreadRadius: 0, // Көлөкөнүн жайылышы
          blurRadius: 10,  // Көлөкөнүн бүдөмүктүгү
          offset: const Offset(0, 4), // Көлөкөнүн жылышы (X, Y)
        ),
      ],
      // border: Border.all(...), // <-- ЧЕК АЛЫНЫП САЛЫНДЫ же КОММЕНТАРИЙГЕ АЛЫНДЫ
    );
  }

  // Чоң карта үчүн жасалгалоо (mainBannerCardDecoration ордуна же ага кошумча)
  static BoxDecoration largeTopicCardDecoration({required BuildContext context}) {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: cardBorderRadius, // Жалпы cardBorderRadius колдонобуз
      boxShadow: [
        BoxShadow(
          color: AppColors.grey.withOpacity(0.15), // 0.25 - бул 25% тунуктук.
          spreadRadius: 1,
          blurRadius: 4, // Бир аз башкача көлөкө
          offset: const Offset(0, 2),
        ),
      ],
      border: Border.all( // Чоң картанын чеги (мисалы, башка түс же калыңдык)
        color: Colors.green.shade600, // Мисалы, бир аз кочкулураак жашыл
        width: 1.5,
      ),
    );
  }

  static BoxDecoration mainBannerCardDecoration({required BuildContext context}) {
    return BoxDecoration(
      color: Colors.white, // Темадан алгандын ордуна түз ак түс
      borderRadius: cardBorderRadius, // Же BorderRadius.circular(12.0)
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08), // Башка карталардагыдай көлөкө
          spreadRadius: 0,
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
      // border: Border.all(...), // Эгер чек болсо, алып салыңыз
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
                borderRadius: BorderRadius.circular(11.0), // Кичине сүрөттүн бурчу
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
                      style: textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold), // Темадан стиль
                    ),
                    const SizedBox(height: 4),
                    if (topic.description.isNotEmpty)
                      Text(
                        topic.description,
                        style: textTheme.bodySmall?.copyWith(color: AppColors.grey), // Темадан стиль
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

  // ЖАҢЫ: Чоң картаны куруучу функция
  static Widget buildLargeTopicCard({
    required BuildContext context,
    required TopicListItemModel topic,
    required VoidCallback onTap,
  }) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: AppDecorations.largeTopicCardDecoration(context: context), // Чоң карта үчүн жасалгалоо
      child: InkWell(
        onTap: onTap,
        borderRadius: AppDecorations.cardBorderRadius, // Жалпы cardBorderRadius
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: AppDecorations.largeCardImageBorderRadius, // Чоң сүрөттүн бурчу
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
                  style: textTheme.bodyMedium?.copyWith(color: AppColors.grey), // Темадан стиль
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