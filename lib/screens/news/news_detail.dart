import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/blocs/news/news_bloc.dart';
import 'package:vet_mobile_app/blocs/news/news_event.dart';
import 'package:vet_mobile_app/blocs/news/news_state.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/data/models/news_article.dart';
import 'package:vet_mobile_app/utils/date_formatter.dart';

class NewsDetail extends StatefulWidget {
  final String articleId;
  const NewsDetail({Key? key, required this.articleId}) : super(key: key);

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  // Using the DateFormatter utility class instead of local method

  @override
  void initState() {
    super.initState();
    // Add a small delay to ensure that the BlocProvider is fully initialized
    Future.microtask(() {
      if (mounted) {
        BlocProvider.of<NewsBloc>(context).add(LoadNewsArticle(articleId: widget.articleId));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () {
            // Use a more robust approach to handle navigation
            if (context.canPop()) {
              context.pop();
            } else {
              // If can't pop, navigate to the news screen
              context.go('/news');
            }
          },
        ),
        title: Text('Жаңылык', 
          style: AppTextStyles.heading2.copyWith(color: AppColors.textPrimary),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        builder: (context, state) {
          if (state is NewsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsArticleLoaded) {
            final NewsArticle article = state.article;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Тема',
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    article.title,
                    style: AppTextStyles.heading3,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    DateFormatter.formatWithPrefix(article.publishedDate, 'Жарыяланды:'),
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                  const SizedBox(height: 16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: (article.imageUrl != null && article.imageUrl!.isNotEmpty)
                        ? Image.network(
                            article.imageUrl!,
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              // Fallback to local asset if network image fails
                              return Image.asset(
                                'assets/images/news_banner.png',
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              );
                            },
                          )
                        : Image.asset(
                            'assets/images/news_banner.png',
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    article.content,
                    style: AppTextStyles.bodyMedium,
                  ),
                ],
              ),
            );
          } else if (state is NewsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Жаңылыкты жүктөөдө ката кетти:',
                    style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(state.message, style: AppTextStyles.bodyMedium),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<NewsBloc>(context).add(LoadNewsArticle(articleId: widget.articleId));
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
                    child: const Text('Кайрадан аракет кылуу'),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Белгисиз абал.'));
          }
        },
      ),
    );
  }
}
