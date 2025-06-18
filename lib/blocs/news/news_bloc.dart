import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vet_mobile_app/blocs/news/news_event.dart' as news_event;
import 'package:vet_mobile_app/blocs/news/news_state.dart';
import 'package:vet_mobile_app/data/models/news_article.dart';

class NewsBloc extends Bloc<news_event.NewsEvent, NewsState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  NewsBloc() : super(const NewsInitial()) {
    on<news_event.NewsEvent>(_onLoadNewsFromFirestore);
    // Башка event'тер болсо, аларды да каттаңыз
  }

  Future<void> _onLoadNewsFromFirestore(
      news_event.NewsEvent event, Emitter<NewsState> emit) async {
    emit(const NewsLoading());

    try {
      final snapshot = await _firestore
          .collection('news')
          .orderBy('publishedDate', descending: true)
          .get();


      if (snapshot.docs.isEmpty) {
        emit(const NewsLoaded([]));
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
}
