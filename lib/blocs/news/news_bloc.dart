import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vet_mobile_app/blocs/news/news_event.dart';
import 'package:vet_mobile_app/blocs/news/news_state.dart';
import 'package:vet_mobile_app/data/models/news_article.dart'; 

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  NewsBloc() : super(NewsInitial()) {
    on<LoadNews>(_onLoadNewsFromFirestore);
    // Башка event'тер болсо, аларды да каттаңыз
  }

  FutureOr<void> _onLoadNewsFromFirestore(LoadNews event, Emitter<NewsState> emit) async {
    print('[NewsBloc] _onLoadNewsFromFirestore: Event received.'); // 1. Event келдиби?
    emit(NewsLoading());
    print('[NewsBloc] _onLoadNewsFromFirestore: Emitted NewsLoading.'); // 2. NewsLoading абалы чыктыбы?
    
    try {
      print('[NewsBloc] _onLoadNewsFromFirestore: Fetching from Firestore...'); // 3. Firestore'го сурам жөнөтүлдүбү?
      final snapshot = await _firestore
          .collection('news')
          .orderBy('publishedDate', descending: true)
          .get();
      
      print('[NewsBloc] _onLoadNewsFromFirestore: Firestore snapshot received. Docs count: ${snapshot.docs.length}'); // 4. Канча документ келди?

      if (snapshot.docs.isEmpty) {
        print('[NewsBloc] _onLoadNewsFromFirestore: No documents found. Emitting NewsLoaded with empty list.');
        emit(const NewsLoaded([]));
        return;
      }
      
      final articles = snapshot.docs.map((doc) {
        print('[NewsBloc] _onLoadNewsFromFirestore: Mapping doc ID: ${doc.id}'); // Ар бир документти текшерүү
        return NewsArticle.fromFirestore(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      
      print('[NewsBloc] _onLoadNewsFromFirestore: Articles mapped. Count: ${articles.length}. Emitting NewsLoaded.');
      emit(NewsLoaded(articles)); // 5. NewsLoaded абалы маалыматтар менен чыктыбы?
    } catch (e, stackTrace) { // stackTrace'ти да кармоо
      print('[NewsBloc] _onLoadNewsFromFirestore: ERROR - $e'); // 6. Ката кеттиби?
      print('[NewsBloc] _onLoadNewsFromFirestore: StackTrace - $stackTrace'); // StackTrace'ти да чыгаруу
      if (e is FirebaseException) {
        emit(NewsError('Firebase катасы: ${e.message} (код: ${e.code})'));
      } else {
        emit(NewsError('Жаңылыктарды жүктөөдө белгисиз ката кетти: $e'));
      }
    }
  }
}
