import 'package:flutter/material.dart';
import 'package:vet_mobile_app/core/bottom_bar.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';

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
        title: Text(topic.title),
      ),
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
      bottomNavigationBar: BottomBar(currentIndex: bottomBarCurrentIndex),
    );
  }
}
