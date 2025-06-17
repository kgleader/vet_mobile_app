import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vet_mobile_app/data/models/news_article.dart';

// Events
abstract class NewsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadNewsEvent extends NewsEvent {}

// States
abstract class NewsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {}
class NewsLoading extends NewsState {}
class NewsLoaded extends NewsState {
  final List<NewsArticle> articles;
  NewsLoaded(this.articles);
}
class NewsError extends NewsState {
  final String message;
  NewsError(this.message);
}
class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsInitial()) {
    on<LoadNewsEvent>((event, emit) async {
      emit(NewsLoading());
      try {
        // Simulate loading news (replace with your actual data fetching logic)
        await Future.delayed(const Duration(seconds: 2));
        final List<NewsArticle> articles = [
          NewsArticle(id: '1', title: 'News 1', content: 'Content 1...', publishedDate: DateTime.now()),
          NewsArticle(id: '2', title: 'News 2', content: 'Content 2...', publishedDate: DateTime.now()),
        ];
        emit(NewsLoaded(articles));
      } catch (e) {
        emit(NewsError('Failed to load news: ${e.toString()}'));
      }
    });
  }
}