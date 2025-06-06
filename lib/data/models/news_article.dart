import 'package:cloud_firestore/cloud_firestore.dart';

class NewsArticle {
  final String id;
  final String title;
  final String content;
  final String? imageUrl; // Сүрөт милдеттүү эмес болушу мүмкүн
  final DateTime publishedDate;
  // Башка керектүү талаалар, мисалы:
  // final String author;
  // final String category;

  NewsArticle({
    required this.id,
    required this.title,
    required this.content,
    this.imageUrl,
    required this.publishedDate,
    // this.author,
    // this.category,
  });

  // Эгер Firebase'ден маалымат алсаңыз, factory конструктор пайдалуу болушу мүмкүн
  factory NewsArticle.fromFirestore(Map<String, dynamic> data, String documentId) {
    return NewsArticle(
      id: documentId,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      imageUrl: data['imageUrl'], // Эгер жок болсо null болот
      publishedDate: (data['publishedDate'] as Timestamp).toDate(), // Firebase Timestamp'тан DateTime'га
      // author: data['author'] ?? 'Unknown',
      // category: data['category'] ?? 'General',
    );
  }

  // Эгер Firebase'ге маалымат жөнөтсөңүз, toJson методу пайдалуу
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'publishedDate': publishedDate, // DateTime Firebase'де Timestamp катары сакталат
      // 'author': author,
      // 'category': category,
    };
  }
}