import 'package:cloud_firestore/cloud_firestore.dart';

class NewsArticle {
  final String id;
  final String title;
  final String content;
  final String? imageUrl;
  final DateTime publishedDate;

  NewsArticle({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl,
    required this.publishedDate,
  });

  factory NewsArticle.fromFirestore(Map<String, dynamic> data, String id) {
    // Always use today's date for testing purposes
    final DateTime publishedDate = DateTime.now();
    
    return NewsArticle(
      id: id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      imageUrl: data['imageUrl'],
      publishedDate: publishedDate,
    );
  }
}