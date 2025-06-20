import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:vet_mobile_app/data/models/news_article.dart';
import 'package:vet_mobile_app/config/theme/app_theme.dart'; // Import custom theme

class NewsDetail extends StatelessWidget {
  final String articleId;

  const NewsDetail({Key? key, required this.articleId}) : super(key: key);

  Future<NewsArticle?> _fetchArticleDetails(String id) async {
    try {
      final docSnapshot = await FirebaseFirestore.instance.collection('news').doc(id).get();
      if (docSnapshot.exists) {
        return NewsArticle.fromFirestore(docSnapshot.data() as Map<String, dynamic>, docSnapshot.id);
      }
    } catch (e) {
      print("Error fetching article details: $e");
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.lightTheme; // Use custom theme

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // Use theme's background color
      appBar: AppBar(
        backgroundColor: theme.appBarTheme.backgroundColor, // Use theme's app bar color
        elevation: theme.appBarTheme.elevation, // Use theme's app bar elevation
        iconTheme: theme.appBarTheme.iconTheme,
        titleTextStyle: theme.appBarTheme.titleTextStyle,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.iconTheme.color),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Жаңылык',
          style: theme.textTheme.bodyMedium, // Use theme's headline style
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<NewsArticle?>(
        future: _fetchArticleDetails(articleId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Жаңылыкты жүктөөдө ката кетти же жаңылык табылган жок.'));
          }

          final article = snapshot.data!;
          final DateFormat formatter = DateFormat('dd MMMM yyyy, HH:mm', 'ky');

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article.title,
                  style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold), // Use theme's headline style
                ),
                const SizedBox(height: 8),
                Text(
                  'Жарыяланды: ${formatter.format(article.publishedDate)}',
                  style: theme.textTheme.bodyMedium!.copyWith(color: Colors.grey[700]), // Use theme's body text style
                ),
                const SizedBox(height: 16),
                if (article.imageUrl != null && article.imageUrl!.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      article.imageUrl!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                          height: 200, color: Colors.grey[300], child: const Icon(Icons.broken_image, size: 50)),
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  article.content,
                  style: theme.textTheme.bodyMedium!.copyWith(height: 1.5), // Use theme's body text style
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
