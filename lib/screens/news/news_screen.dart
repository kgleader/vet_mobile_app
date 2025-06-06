import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart'; // Датаны форматтоо үчүн
import 'package:vet_mobile_app/blocs/news/news_bloc.dart';
import 'package:vet_mobile_app/blocs/news/news_event.dart';
import 'package:vet_mobile_app/blocs/news/news_state.dart';
import 'package:vet_mobile_app/data/models/news_article.dart';
import 'package:vet_mobile_app/screens/news/news_detail.dart'; // Деталдуу экранга өтүү үчүн

// Эгер AppColors жана AppLogo бар болсо, аларды импорттоо
// import 'package:vet_mobile_app/core/themes/colors_app.dart';
// import 'package:vet_mobile_app/core/widgets/app_logo.dart';


class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    super.initState();
    // БУЛ ЖЕРДЕ context.read<NewsBloc>().add(LoadNews()); ДЕГЕН САТЫПТЫ АЛЫП САЛЫҢЫЗ
    // ЖЕ КОММЕНТАРИЙГЕ АЛЫҢЫЗ, СЕБЕБИ РОУТЕРДЕ ЖАСАЛЫП ЖАТАТ.
    // Мисалы:
    // // context.read<NewsBloc>().add(LoadNews()); 
  }

  @override
  Widget build(BuildContext context) {
    // Эгер NewsBloc бул жерде биринчи жолу колдонулса, BlocProvider менен ороо керек.
    // Мисалы, MaterialApp'дун home же route'тарында.
    // Азырынча, ал жогору жактан берилди деп коёлу.
    // Эгер жок болсо, бул жерде BlocProvider кошуу керек:
    // return BlocProvider(
    //   create: (context) => NewsBloc()..add(LoadNews()), // LoadNews сиздин event'иңиздин аты
    //   child: Scaffold(...)
    // );

    return Scaffold(
      backgroundColor: const Color(0xFFF8F0E5), // Дизайндагы фон түсү (болжолдуу)
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Же дизайндагы түс
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87), // Же AppColors.primary
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Жаңылыктар',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold), // Же AppColors.textPrimary
        ),
        centerTitle: true,
        // actions: const [
        //   Padding(
        //     padding: EdgeInsets.only(right: 16.0),
        //     child: AppLogo(), // Эгер логотип бар болсо
        //   ),
        // ],
      ),
      body: BlocBuilder<NewsBloc, NewsState>(
        // Эгер NewsBloc'ту бул жерде BlocProvider менен түзсөңүз, бул builder'ды ошол child'га коюңуз
        // buildWhen: (previous, current) => previous != current, // Керек болсо
        builder: (context, state) {
          if (state is NewsInitial || state is NewsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NewsLoaded) {
            if (state.articles.isEmpty) {
              return const Center(child: Text('Азырынча жаңылыктар жок.'));
            }
            // "Тема" үчүн биринчи жаңылыкты алуу
            final NewsArticle? featuredArticle = state.articles.isNotEmpty ? state.articles.first : null;
            // "Блогдор" үчүн калган жаңылыктар
            final List<NewsArticle> blogArticles = state.articles.length > 1 ? state.articles.sublist(1) : [];

            return ListView( // SingleChildScrollView + Column да колдонсо болот
              padding: const EdgeInsets.all(16.0),
              children: [
                if (featuredArticle != null)
                  _FeaturedArticleCard(article: featuredArticle),
                
                if (blogArticles.isNotEmpty) ...[
                  const SizedBox(height: 24),
                  const Text(
                    'Блогдор',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 12),
                  ...blogArticles.map((article) => _BlogArticleListItem(article: article)).toList(),
                ]
              ],
            );
          } else if (state is NewsError) {
            return Center(child: Text('Ката кетти: ${state.message}'));
          }
          return const Center(child: Text('Белгисиз абал.'));
        },
      ),
      // Бул жерге BottomNavigationBar'ды кошсоңуз болот, эгер ал ушул экранга тиешелүү болсо
    );
  }
}

// "Тема" (Featured Article) үчүн виджет
class _FeaturedArticleCard extends StatelessWidget {
  final NewsArticle article;
  const _FeaturedArticleCard({required this.article});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd MMM', 'ky'); // Кыргызча дата форматтоо
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => NewsDetail(articleId: article.id)), // articleId'ни берүү
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Тема',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          if (article.imageUrl != null && article.imageUrl!.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                article.imageUrl!,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => 
                  Container(height: 200, color: Colors.grey[300], child: const Icon(Icons.broken_image, size: 50)),
              ),
            ),
          const SizedBox(height: 12),
          Text(
            article.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
          const SizedBox(height: 6),
          Text(
            article.content, // Бул жерде кыскача мазмун болушу керек (мисалы, content'тин башы)
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          const SizedBox(height: 8),
          Text(
            'Posted on ${formatter.format(article.publishedDate)}',
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

// "Блогдор" тизмесиндеги ар бир элемент үчүн виджет
class _BlogArticleListItem extends StatelessWidget {
  final NewsArticle article;
  const _BlogArticleListItem({required this.article});

  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd MMM', 'ky');

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => NewsDetail(articleId: article.id)), // articleId'ни берүү
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.imageUrl != null && article.imageUrl!.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  article.imageUrl!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => 
                    Container(width: 100, height: 100, color: Colors.grey[300], child: const Icon(Icons.image_not_supported, size: 40)),
                ),
              )
            else
              Container( // Сүрөт жок болсо, орун ээлөөчү
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Icon(Icons.article, size: 40, color: Colors.grey),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    article.content, // Бул жерде да кыскача мазмун
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Posted on ${formatter.format(article.publishedDate)}',
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
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
