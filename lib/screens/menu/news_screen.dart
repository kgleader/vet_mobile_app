import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // Датаны форматтоо үчүн
import 'package:vet_mobile_app/blocs/news/news_bloc.dart';
import 'package:vet_mobile_app/blocs/news/news_event.dart';
import 'package:vet_mobile_app/blocs/news/news_state.dart';
import 'package:vet_mobile_app/data/models/news_article.dart';
import 'package:vet_mobile_app/core/app_colors.dart';
import 'package:vet_mobile_app/core/app_text_styles.dart';
import 'package:vet_mobile_app/core/app_logo.dart';
import 'package:vet_mobile_app/config/router/route_names.dart'; // Керек болсо
import 'package:go_router/go_router.dart'; // Керек болсо

class NewsScreen extends StatefulWidget { // StatelessWidget'тен StatefulWidget'ке өзгөртүлдү
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
              // Эгер артка кайтуу мүмкүн болбосо, негизги менюга өтүү (мисалы)
              // Бул жерде сиздин негизги меню маршрутуңуздун атын колдонуңуз
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
          if (state is NewsInitial || state is NewsLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primary));
          } else if (state is NewsLoaded) {
            if (state.articles.isEmpty) {
              return const Center(child: Text('Азырынча жаңылыктар жок.'));
            }

            // "Тема" үчүн биринчи жаңылыкты алуу (эгер бар болсо)
            final NewsArticle? featuredArticle = state.articles.isNotEmpty ? state.articles.first : null;
            // "Блогдор" үчүн калган жаңылыктар
            final List<NewsArticle> blogArticles = state.articles.length > 1 ? state.articles.sublist(1) : [];

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (featuredArticle != null)
                    _buildMainNewsBanner(
                      context,
                      article: featuredArticle, // NewsArticle объектисин берүү
                      onReadMore: () {
                        print("Кеңирирээк басылды - негизги жаңылык: ${featuredArticle.title}");
                        // TODO: Жаңылыктын толук бетине өтүү
                        // context.push('${RouteNames.newsDetail}/${featuredArticle.id}');
                      },
                    ),
                  const SizedBox(height: 24),
                  if (blogArticles.isNotEmpty) ...[
                    Text(
                      'Блогдор',
                      style: AppTextStyles.heading3.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    ...blogArticles.map((article) => _buildBlogItem(
                          context,
                          article: article, // NewsArticle объектисин берүү
                          onTap: () {
                            print("Блог басылды: ${article.title}");
                            // TODO: Блогдун толук бетине өтүү
                            // context.push('${RouteNames.blogDetail}/${article.id}');
                          },
                        )).toList(),
                  ]
                ],
              ),
            );
          } else if (state is NewsError) {
            return Center(child: Text('Ката кетти: ${state.message}'));
          }
          return const Center(child: Text('Белгисиз абал.')); // Күтүлбөгөн абал үчүн
        },
      ),
    );
  }

  Widget _buildMainNewsBanner(
    BuildContext context, {
    required NewsArticle article, // NewsArticle кабыл алуу
    required VoidCallback onReadMore,
  }) {
    final DateFormat formatter = DateFormat('dd MMMM yyyy', 'ky'); // Кыргызча дата
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (article.imageUrl != null && article.imageUrl!.isNotEmpty)
            Image.network( // Image.asset'тен Image.network'ко өзгөртүлдү
              article.imageUrl!,
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container( // Сүрөт жүктөлбөсө, жергиликтүү сүрөттү же орун ээлөөчүнү көрсөтүү
                  height: 180,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Image.asset( // Мисал катары жергиликтүү сүрөт
                    'assets/images/news_banner.png', // Бул сүрөт бар болушу керек
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, err, st) => const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
                  )
                );
              },
            )
          else // Эгер imageUrl жок болсо
            Image.asset( // Жергиликтүү демейки сүрөт
              'assets/images/news_banner.png', // Бул сүрөт бар болушу керек
              width: double.infinity,
              height: 180,
              fit: BoxFit.cover,
               errorBuilder: (context, error, stackTrace) => Container(height: 180, color: Colors.grey[300], child: const Center(child: Icon(Icons.broken_image, size: 50, color: Colors.grey))),
            ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title, // Firebase'ден келген аталыш
                  style: AppTextStyles.heading3.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text( // Датаны кошуу
                  'Жарыяланды: ${formatter.format(article.publishedDate)}',
                  style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 8),
                Text(
                  article.content, // Firebase'ден келген мазмун (кыскартылышы мүмкүн)
                  style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: onReadMore,
                    child: Text(
                      'Кеңирирээк',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlogItem(
    BuildContext context, {
    required NewsArticle article, // NewsArticle кабыл алуу
    required VoidCallback onTap,
  }) {
    final DateFormat formatter = DateFormat('dd.MM.yyyy', 'ky'); // Кыргызча дата
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              if (article.imageUrl != null && article.imageUrl!.isNotEmpty)
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network( // Image.asset'тен Image.network'ко
                    article.imageUrl!,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) { // Сүрөт жүктөлбөсө
                       return Image.asset( // Жергиликтүү демейки сүрөт
                        'assets/images/news_topic1.png', // Мисал, бул сүрөт бар болушу керек
                        width: 80, height: 80, fit: BoxFit.cover,
                        errorBuilder: (ctx, err, st) => Container(width: 80, height: 80, color: Colors.grey[200], child: const Icon(Icons.image_not_supported, size: 30, color: Colors.grey)),
                      );
                    },
                  ),
                )
              else // Эгер imageUrl жок болсо
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.asset( // Жергиликтүү демейки сүрөт
                    'assets/images/news_topic1.png', // Мисал, бул сүрөт бар болушу керек
                    width: 80, height: 80, fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(width: 80, height: 80, color: Colors.grey[200], child: const Icon(Icons.image_not_supported, size: 30, color: Colors.grey)),
                  ),
                ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title, // Firebase'ден келген аталыш
                      style: AppTextStyles.bodyBold,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Жарыяланды: ${formatter.format(article.publishedDate)}', // Firebase'ден келген дата
                      style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
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
}
