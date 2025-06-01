// /Users/meerimakmatova/vet_mobile_app/lib/screens/menu/diseases_screen.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/config/constants/sizes.dart';
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/core/app_logo.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';

class DiseasesScreen extends StatelessWidget {
  final int bottomBarCurrentIndex;
  
  const DiseasesScreen({super.key, this.bottomBarCurrentIndex = 0});

  @override
  Widget build(BuildContext context) {
    final List<TopicListItemModel> diseaseTopics = [
      TopicListItemModel(
        id: 'disease_topic_1',
        imagePath: 'assets/images/disease_topic1.jpg',
        title: 'Ооруу',
        description: 'Lorem Ipsum is simply dummy text of the',
        fullDescription: 'Бул бөлүмдө малдын жугуштуу оорулары, алардын негизги белгилери, диагностикалоо ыкмалары жана заманбап дарылоо жолдору жөнүндө кеңири маалымат берилет. Ошондой эле, оорулардын алдын алуу жана чарбада эпизоотиялык кырдаалды көзөмөлдөө боюнча сунуштар камтылган.'
      ),
      TopicListItemModel(
        id: 'disease_topic_2',
        imagePath: 'assets/images/disease_topic2.jpg',
        title: 'Ооруу',
        description: 'Lorem Ipsum is simply dummy text of the',
        fullDescription: 'Малдын мите курттардан пайда болуучу оорулары (гельминтоздор) жана алардын экономикалык зыяны тууралуу маалымат. Гельминтоздордун түрлөрү, аларды аныктоо, дарылоо жана алдын алуу боюнча комплекстүү чаралар, дегельминтизациялоо схемалары келтирилген.'
      ),
      TopicListItemModel(
        id: 'disease_topic_3',
        imagePath: 'assets/images/disease_topic3.jpg',
        title: 'Ооруу',
        description: 'Lorem Ipsum is simply dummy text of the',
        fullDescription: 'Малдын зат алмашуу процесстеринин бузулушунан келип чыккан оорулар (мисалы, кетоз, остеодистрофия ж.б.) жана алардын себептери. Бул оорулардын клиникалык белгилери, диагностикасы, дарылоо принциптери жана тоюттандырууну оптималдаштыруу аркылуу алдын алуу жолдору баяндалат.'
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => GoRouter.of(context).go(RouteNames.menu),
        ),
        title: const Text(
          'Ооруу',
          style: TextStyle(
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
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Banner image
          Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: const AssetImage('assets/images/grass_banner.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            margin: const EdgeInsets.only(bottom: 16),
          ),

          // Description
          const Padding(
            padding: EdgeInsets.only(bottom: 24),
            child: Text(
              'Lorem Ipsum is simply dummy text of the printing',
              style: TextStyle(fontSize: 16),
            ),
          ),

          // Topics list
          ...diseaseTopics.map((topic) => _buildTopicCard(context, topic)),
        ],
      ),
    );
  }

  Widget _buildTopicCard(BuildContext context, TopicListItemModel topic) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          GoRouter.of(context).pushNamed(
            RouteNames.topicDetail,
            extra: {
              'topic': topic,
              'currentIndex': 0,
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Topic image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  topic.imagePath,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 100,
                      height: 100,
                      color: Colors.grey[300],
                      child: const Icon(Icons.error),
                    );
                  },
                ),
              ),
              const SizedBox(width: 12),
              
              // Topic content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      topic.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      topic.description,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Arrow icon
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}