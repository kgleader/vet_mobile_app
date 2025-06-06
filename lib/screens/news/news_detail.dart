import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:vet_mobile_app/data/models/news_article.dart'; // NewsArticle моделин импорттоо

class NewsDetail extends StatelessWidget {
  final String articleId; // Жаңылыктын ID'син кабыл алуу

  const NewsDetail({super.key, required this.articleId});

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
    return Scaffold(
      // backgroundColor: const Color(0xFFF8F0E5), // NewsScreen'дегидей фон
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        // elevation: 0,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.black87),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        title: const Text('Жаңылык'), // AppBar'дын аталышын өзгөртсө болот
        // centerTitle: true,
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
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  'Жарыяланды: ${formatter.format(article.publishedDate)}',
                  style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                ),
                const SizedBox(height: 16),
                if (article.imageUrl != null && article.imageUrl!.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Image.network(
                      article.imageUrl!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(height: 200, color: Colors.grey[300], child: const Icon(Icons.broken_image, size: 50)),
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  article.content,
                  style: const TextStyle(fontSize: 16, height: 1.5), // Тексттин бийиктиги
                ),
                // Башка маалыматтарды ушул жерге кошсоңуз болот
              ],
            ),
          );
        },
      ),
    );
  }
}
