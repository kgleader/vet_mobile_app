import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // Датаны форматтоо үчүн
import 'package:vet_mobile_app/blocs/news/news_bloc.dart';
import 'package:vet_mobile_app/blocs/news/news_event.dart' as news_event; // Жаңылыктар окуяларын импорттоо
import 'package:vet_mobile_app/blocs/news/news_state.dart';
import 'package:vet_mobile_app/data/models/news_article.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/core/app_logo.dart';
import 'package:vet_mobile_app/config/router/route_names.dart'; // Керек болсо
import 'package:go_router/go_router.dart'; // Керек болсо

class NewsScreen extends StatefulWidget { // StatefulWidget'ке кайтарылды
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  // initState'те эч нерсе кылуунун кереги жок, анткени LoadNews роутерде жөнөтүлөт

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
          if (state is NewsInitial) {
            return Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                onPressed: () {
                  context.read<NewsBloc>().add(news_event.LoadNewsEvent()); // Dispatch the event to the NewsBloc
                },
                child: Text(
                  'Жаңылыктарды жүктөө',
                  style: AppTextStyles.buttonText.copyWith(color: Colors.white),
                ),
              ),
            );
          } else if (state is NewsLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          } else if (state is NewsLoaded) {
            if (state.articles.isEmpty) {
              return const Center(
                child: Text(
                  'Азырынча жаңылыктар жок.',
                  style: AppTextStyles.body,
                ),
              );
            }

            final NewsArticle? featuredArticle = state.articles.isNotEmpty ? state.articles.first : null;
            final List<NewsArticle> blogArticles = state.articles.length > 1 ? state.articles.sublist(1) : [];

            return SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (featuredArticle != null) ...[
                    Text( // "Тема" аталышы кайра кошулду
                      'Тема', 
                      style: AppTextStyles.heading3.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 8),
                    _buildMainNewsBanner( // _buildMainNewsBanner кайра кошулду
                      context,
                      article: featuredArticle,
                      onReadMore: () {
                        if (featuredArticle.id.isNotEmpty) {
                          context.push('/news/${featuredArticle.id}');
                        } else {
                          print("Error: featuredArticle.id is empty, cannot navigate.");
                           ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Жаңылыктын чоо-жайын ачууда ката кетти.')),
                          );
                        }
                      },
                    ),
                  ],
                  if (featuredArticle != null && blogArticles.isNotEmpty)
                    const SizedBox(height: 24),

                  if (blogArticles.isNotEmpty) ...[
                    Text( // "Блогдор" аталышы кайра кошулду
                      'Блогдор',
                      style: AppTextStyles.heading3.copyWith(fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                    ),
                    const SizedBox(height: 16),
                    ListView.separated( // Блогдор үчүн ListView.separated
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: blogArticles.length,
                      itemBuilder: (context, index) {
                        final article = blogArticles[index];
                        return _buildBlogItem( // _buildBlogItem кайра кошулду
                          context,
                          article: article,
                          itemIndex: index, 
                          onTap: () {
                            if (article.id.isNotEmpty) {
                              context.push('/news/${article.id}');
                            } else {
                              print("Error: article.id is empty, cannot navigate.");
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Жаңылыктын чоо-жайын ачууда ката кетти.')),
                              );
                            }
                          },
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                    ),
                  ]
                ],
              ),
            );
          } else if (state is NewsError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Жаңылыктарды жүктөөдө ката кетти: ${state.message}',
                      style: AppTextStyles.body.copyWith(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      ),
                      onPressed: () {
                        context.read<NewsBloc>().add(news_event.LoadNewsEvent()); // Же сиздин жүктөө окуяңыздын аталышы
                      },
                      child: Text(
                        'Кайра аракет кылуу',
                        style: AppTextStyles.buttonText.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text('Белгисиз абал.'));
        },
      ),
    );
  }

  // _buildMainNewsBanner виджети (Figma'га ылайыкташтырылган версия)
  Widget _buildMainNewsBanner(
    BuildContext context, {
    required NewsArticle article,
    required VoidCallback onReadMore,
  }) {
    final DateFormat formatter = DateFormat("'Posted on' MMM d", 'en_US'); 
    String mainContent = article.content;
    if (mainContent.length > 150) {
      mainContent = '${mainContent.substring(0, 150)}...';
    }

    return InkWell(
      onTap: onReadMore,
      child: Card(
        elevation: 1.0, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), 
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 8.0),
              child: Text(
                mainContent,
                style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                maxLines: 4, 
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (article.imageUrl != null && article.imageUrl!.isNotEmpty)
              Image.network(
                article.imageUrl!,
                width: double.infinity,
                height: 170, 
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/news_banner.png',
                    width: double.infinity,
                    height: 170,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, st) => Container(
                        height: 170,
                        width: double.infinity,
                        color: Colors.grey[200],
                        child: const Icon(Icons.broken_image, size: 40, color: Colors.grey)),
                  );
                },
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: double.infinity,
                    height: 170,
                    color: Colors.grey[200],
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                        color: AppColors.primary,
                      ),
                    ),
                  );
                },
              )
            else
              Image.asset(
                'assets/images/news_banner.png',
                width: double.infinity,
                height: 170,
                fit: BoxFit.cover,
                errorBuilder: (ctx, err, st) => Container(
                    height: 170,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image_not_supported, size: 40, color: Colors.grey)),
              ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 10.0),
              child: Text(
                formatter.format(article.publishedDate),
                style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // _buildBlogItem виджети (Figma'га ылайыкташтырылган версия)
  Widget _buildBlogItem(
    BuildContext context, {
    required NewsArticle article,
    required int itemIndex,
    required VoidCallback onTap,
  }) {
    final DateFormat formatter = DateFormat("'Posted on' MMM d", 'en_US');
    final List<String> placeholderImages = [
      'assets/images/news_topic1.png',
      'assets/images/news_topic2.png',
      'assets/images/news_topic3.png',
    ];
    final String placeholderImage = placeholderImages[itemIndex % placeholderImages.length];

    String description = article.content;
    if (description.length > 50) { 
      description = '${description.substring(0, 50)}...';
    }

    return InkWell(
      onTap: onTap,
      child: Container( 
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: (article.imageUrl != null && article.imageUrl!.isNotEmpty)
                  ? Image.network(
                      article.imageUrl!,
                      width: 60, 
                      height: 60, 
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(
                          placeholderImage,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, err, st) => Container(
                              width: 60, height: 60, color: Colors.grey[200], child: const Icon(Icons.broken_image, size: 20, color: Colors.grey)),
                        );
                      },
                      loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey[200],
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2.0,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                  : null,
                              color: AppColors.primary,
                            ),
                          ),
                        );
                      },
                    )
                  : Image.asset(
                      placeholderImage,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, err, st) => Container(
                          width: 60, height: 60, color: Colors.grey[200], child: const Icon(Icons.image_not_supported, size: 20, color: Colors.grey)),
                    ),
            ),
            const SizedBox(width: 12), 
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title, 
                    style: AppTextStyles.bodyBold.copyWith(color: AppColors.textPrimary, fontSize: 14), 
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description, 
                    style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary, fontSize: 12), 
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    formatter.format(article.publishedDate),
                    style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary.withOpacity(0.7), fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
