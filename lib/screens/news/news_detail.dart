import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:vet_mobile_app/blocs/news/news_bloc.dart';
import 'package:vet_mobile_app/blocs/news/news_event.dart';
import 'package:vet_mobile_app/blocs/news/news_state.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/data/models/news_article.dart';

class NewsDetail extends StatefulWidget {
  final String articleId;
  const NewsDetail({Key? key, required this.articleId}) : super(key: key);

  @override
  State<NewsDetail> createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NewsBloc>(context).add(LoadNewsArticle(articleId: widget.articleId));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
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
            final DateFormat formatter = DateFormat('dd MMMM yyyy, HH:mm', 'ky');

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    style: theme.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Жарыяланды: ${formatter.format(article.publishedDate)}',
                    style: theme.textTheme.bodySmall!.copyWith(color: Colors.grey[700]),
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
                              print('Error loading image: $error');
                              return Container(
                                width: double.infinity,
                                height: 200,
                                color: Colors.grey[300],
                                child: const Center(
                                  child: Icon(Icons.image_not_supported, size: 64, color: Colors.grey),
                                ),
                              );
                            },
                          )
                        : Container(
                            width: double.infinity,
                            height: 200,
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.image_not_supported, size: 64, color: Colors.grey),
                            ),
                          ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    article.content,
                    style: theme.textTheme.bodyMedium!.copyWith(height: 1.5),
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
