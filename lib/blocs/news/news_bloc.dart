import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vet_mobile_app/blocs/news/news_event.dart';
import 'package:vet_mobile_app/blocs/news/news_state.dart';
import 'package:vet_mobile_app/data/models/news_item_model.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<LoadNews>(_onLoadNews);
  }

  FutureOr<void> _onLoadNews(LoadNews event, Emitter<NewsState> emit) async {
    emit(NewsLoading());
    
    try {
      // В будущем здесь будет вызов API или Firebase
      // Пока используем моковые данные
      await Future.delayed(const Duration(seconds: 1)); // Имитация задержки сети
      
      final news = [
        NewsItem(
          title: 'Ветеринардык кызматтын жаңы багыттары',
          summary: 'Азыркы учурда ветеринардык кызмат көрсөтүүнүн жаңы ыкмалары колдонулууда.',
          imageUrl: 'assets/images/horse_topic1.png', // Using local image
          date: '20.05.2023',
        ),
        NewsItem(
          title: 'Малдарды эмдөө боюнча кампания башталды',
          summary: 'Бул жылдагы эмдөө иш-чаралары башталды. Бардык фермерлерге катышуу сунушталат.',
          imageUrl: 'assets/images/disease_topic1.jpg', // Using local image
          date: '15.05.2023',
        ),
        NewsItem(
          title: 'Жайыт чарбасын туура башкаруу',
          summary: 'Жайыттарды туура пайдалануу боюнча жаңы сунуштар чыкты.',
          imageUrl: 'assets/images/feed_topic1.jpg', // Using local image
          date: '10.05.2023',
        ),
      ];
      
      emit(NewsLoaded(news));
    } catch (e) {
      emit(NewsError('Жаңылыктарды жүктөөдө ката кетти: $e'));
    }
  }
}