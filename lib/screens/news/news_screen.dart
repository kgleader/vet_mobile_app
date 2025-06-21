import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/blocs/news/news_bloc.dart';
import 'package:vet_mobile_app/blocs/news/news_event.dart';
import 'package:vet_mobile_app/blocs/news/news_state.dart';
import 'package:vet_mobile_app/config/router/go_router.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_logo.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/data/models/news_article.dart';
import 'package:vet_mobile_app/utils/date_formatter.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  // Helper method to get different topic images based on index
  String _getTopicImage(int index) {
    // Cycle through the 3 topic images
    switch (index % 3) {
      case 0:
        return 'assets/images/news_topic1.png';
      case 1:
        return 'assets/images/news_topic2.png';
      case 2:
        return 'assets/images/news_topic3.png';
      default:
        return 'assets/images/news_topic1.png';
    }
  }
  
  // Using DateFormatter utility class instead of local method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(RouteNames.menu);
            }
          },
        ),
        title: Text(
          'Жаңылыктар',
          style: AppTextStyles.heading2.copyWith(color: AppColors.textPrimary),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: AppLogo(),
          ),
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsLoaded) {
            final List<NewsArticle> articles = state.articles;
            if (articles.isEmpty) {
              return const Center(child: Text('Блогдор жок'));
            }
            
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Banner image for news
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.asset(
                      'assets/images/news_banner.png',
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                  child: Text(
                    'Блогдор',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: articles.length,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    itemBuilder: (context, index) {
                      // Format date using DateFormatter utility
                      final formattedDate = DateFormatter.formatWithPrefix(articles[index].publishedDate, 'Жарыяланды:');
                      
                      return InkWell(
                        onTap: () {
                          // Use the named route with parameters for better navigation
                          context.goNamed('news_detail', pathParameters: {'articleId': articles[index].id});
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Image section
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: articles[index].imageUrl != null && articles[index].imageUrl!.isNotEmpty
                                  ? Image.network(
                                      articles[index].imageUrl!,
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        // Use different topic images based on index
                                        final String topicImage = _getTopicImage(index);
                                        return Image.asset(
                                          topicImage,
                                          width: 80,
                                          height: 80,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                    )
                                  : Image.asset(
                                      _getTopicImage(index),
                                      width: 80,
                                      height: 80,
                                      fit: BoxFit.cover,
                                    ),
                              ),
                              const SizedBox(width: 12),
                              // Text content section
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      articles[index].title,
                                      style: AppTextStyles.bodyMedium.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      articles[index].content,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.bodyMedium,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      formattedDate,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (state is NewsError) {
            return Center(child: Text('Error: ${state.message}'));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
