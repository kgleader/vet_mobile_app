import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/core/app_logo.dart';

class SheepDiseasesScreen extends StatefulWidget {
  final int bottomBarCurrentIndex;

  const SheepDiseasesScreen({super.key, this.bottomBarCurrentIndex = 0});

  @override
  State<SheepDiseasesScreen> createState() => _SheepDiseasesScreenState();
}

class _SheepDiseasesScreenState extends State<SheepDiseasesScreen> {
  @override
  Widget build(BuildContext context) {
    const String categoryTitle = "Дарылоо";

    final List<TopicListItemModel> diseaseTopics = [
      TopicListItemModel(
        id: 'disease_topic_1',
        imagePath: 'assets/images/drug_topic_image1.png',
        title: 'Жугуштуу оорулар',
        description: 'Койлордун негизги жугуштуу оорулары жана аларды дарылоо ыкмалары.',
        fullDescription: 'Койлор арасында кеңири таралган жугуштуу оорулар, алардын белгилери, диагностикасы жана заманбап дарылоо ыкмалары жөнүндө маалымат.'
      ),
      TopicListItemModel(
        id: 'disease_topic_2',
        imagePath: 'assets/images/drug_topic_image2.png',
        title: 'Мите курттар',
        description: 'Койлордун мите курт оорулары жана алар менен күрөшүү.',
        fullDescription: 'Ички жана сырткы мите курттардан келип чыгуучу оорулар, алардын алдын алуу жана дарылоо боюнча сунуштар.'
      ),
      TopicListItemModel(
        id: 'disease_topic_3',
        imagePath: 'assets/images/drug_topic_image3.png',
        title: 'Алдын алуу чаралары',
        description: 'Койлордун ооруларын алдын алуу боюнча негизги чаралар.',
        fullDescription: 'Вакцинация, дезинфекция, туура багуу жана тоюттандыруу аркылуу койлордун ооруларын алдын алуунун маанилүүлүгү.'
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => GoRouter.of(context).go(RouteNames.goats),
        ),
        title: Text(
          categoryTitle,
          style: const TextStyle(
            color: Colors.black,
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Sizes.paddingL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 180,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  'assets/images/sheep_drug_banner.png',
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: const Center(child: Text('Баннер жүктөлбөдү', textAlign: TextAlign.center,))
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.only(left: 4.0, bottom: 8.0),
              child: Text(
                "Тема",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: diseaseTopics.length,
                itemBuilder: (context, index) {
                  return _buildTopicCard(
                    context: context,
                    topic: diseaseTopics[index],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopicCard({
    required BuildContext context,
    required TopicListItemModel topic,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 2,
      child: InkWell(
        onTap: () => _navigateToTopic(context, topic),
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  topic.imagePath,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                   errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Container(
                      width: 80, height: 80, color: Colors.grey[200],
                      child: Icon(Icons.broken_image, color: Colors.grey[400])
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      topic.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
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

  void _navigateToTopic(BuildContext context, TopicListItemModel topic) {
    GoRouter.of(context).pushNamed(
      RouteNames.topicDetail,
      extra: {'topic': topic, 'currentIndex': widget.bottomBarCurrentIndex},
    );
  }
}
