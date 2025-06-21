import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vet_mobile_app/blocs/news/news_event.dart';
import 'package:vet_mobile_app/blocs/news/news_state.dart';
import 'package:vet_mobile_app/data/models/news_article.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  NewsBloc() : super(NewsInitial()) {
    on<LoadNewsEvent>(_onLoadNewsFromFirestore);
    on<LoadNewsArticle>(_onLoadNewsArticle);
  }

  Future<void> _onLoadNewsFromFirestore(
      LoadNewsEvent event, Emitter<NewsState> emit) async {
    emit(NewsLoading());

    try {
      final snapshot = await _firestore
          .collection('news')
          .orderBy('publishedDate', descending: true)
          .get();

      if (snapshot.docs.isEmpty) {
        emit(NewsLoaded([]));
        return;
      }

      final articles = snapshot.docs.map((doc) {
        return NewsArticle.fromFirestore(
            doc.data(), doc.id);
      }).toList();

      emit(NewsLoaded(articles));
    } catch (e) {
      if (e is FirebaseException) {
        emit(NewsError('Firebase катасы: ${e.message} (код: ${e.code})'));
      } else {
        emit(NewsError('Жаңылыктарды жүктөөдө белгисиз ката кетти: $e'));
      }
    }
  }
  
  Future<void> _onLoadNewsArticle(
      LoadNewsArticle event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    
    try {
      final docSnapshot = await _firestore
          .collection('news')
          .doc(event.articleId)
          .get();
          
      if (!docSnapshot.exists) {
        emit(NewsError('Бул ID\'ге ээ жаңылык табылган жок: ${event.articleId}'));
        return;
      }
      
      final article = NewsArticle.fromFirestore(
          docSnapshot.data()!, docSnapshot.id);
          
      emit(NewsArticleLoaded(article: article));
    } catch (e) {
      if (e is FirebaseException) {
        emit(NewsError('Firebase катасы: ${e.message} (код: ${e.code})'));
      } else {
        emit(NewsError('Жаңылыкты жүктөөдө белгисиз ката кетти: $e'));
      }
    }
  }

  // Method to create a new article with current date
  Future<void> createNewsArticle(String title, String content, String? imageUrl) async {
    try {
      await _firestore.collection('news').add({
        'title': title,
        'content': content,
        'imageUrl': imageUrl,
        'publishedDate': FieldValue.serverTimestamp(), // Always use server timestamp for consistency
      });
      // After adding, reload the news list
      add(LoadNewsEvent());
    } catch (e) {
      // Handle errors
      print('Error creating news article: $e');
    }
  }
}
