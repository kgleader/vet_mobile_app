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

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

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
            padding: EdgeInsets.only(right: 16.0), // Sizes.paddingL ордуна конкреттүү маани
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
              return const Center(child: Text('Жаңылыктар жок'));
            }
            return ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    context.go('/news/${articles[index].id}');
                  },
                  child: Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            articles[index].title,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            articles[index].content,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
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
