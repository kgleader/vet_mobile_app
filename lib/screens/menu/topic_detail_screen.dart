import 'package:flutter/material.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/widgets/main_scaffold.dart';
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
    return MainScaffold(
      currentIndex: bottomBarCurrentIndex,
      title: topic.title,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: CircleAvatar(
            backgroundColor: const Color(0xFF38A169), // figmaGreen
            radius: 18,
            child: AppLogo(
              width: 24,
              // Use standard onTap to navigate to profile
            ),
          ),
        ),
      ],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (topic.imagePath.isNotEmpty)
                Center(
                  child: Image.asset(
                    topic.imagePath,
                    height: 200, // Adjust height as needed
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(Icons.image_not_supported, size: 100); // Placeholder for error
                    },
                  ),
                ),
              const SizedBox(height: 16.0),
              Text(
                topic.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
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
