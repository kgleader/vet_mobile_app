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
    print('[NewsBloc] _onLoadNewsFromFirestore: Event received.');
    emit(const NewsLoading());
    print('[NewsBloc] _onLoadNewsFromFirestore: Emitted NewsLoading.');

    try {
      print(
          '[NewsBloc] _onLoadNewsFromFirestore: Fetching from Firestore...');
      final snapshot = await _firestore
          .collection('news')
          .orderBy('publishedDate', descending: true)
          .get();

      print(
          '[NewsBloc] _onLoadNewsFromFirestore: Firestore snapshot received. Docs count: ${snapshot.docs.length}');

      if (snapshot.docs.isEmpty) {
        print(
            '[NewsBloc] _onLoadNewsFromFirestore: No documents found. Emitting NewsLoaded with empty list.');
        emit(const NewsLoaded([]));
        return;
      }

      final articles = snapshot.docs.map((doc) {
        print(
            '[NewsBloc] _onLoadNewsFromFirestore: Mapping doc ID: ${doc.id}');
        return NewsArticle.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      print(
          '[NewsBloc] _onLoadNewsFromFirestore: Articles mapped. Count: ${articles.length}. Emitting NewsLoaded.');
      emit(NewsLoaded(articles));
    } catch (e, stackTrace) {
      print('[NewsBloc] _onLoadNewsFromFirestore: ERROR - $e');
      print('[NewsBloc] _onLoadNewsFromFirestore: StackTrace - $stackTrace');
      if (e is FirebaseException) {
        emit(NewsError('Firebase катасы: ${e.message} (код: ${e.code})'));
      } else {
        emit(NewsError('Жаңылыктарды жүктөөдө белгисиз ката кетти: $e'));
      }
    }
  }
}
