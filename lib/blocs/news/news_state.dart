import 'package:vet_mobile_app/data/models/news_article.dart';
import 'package:equatable/equatable.dart';

abstract class NewsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsArticle> articles;
  
  NewsLoaded(this.articles);
  
  @override
  List<Object?> get props => [articles];
}

class NewsArticleLoaded extends NewsState {
  final NewsArticle article;

  NewsArticleLoaded({required this.article});
  
  @override
  List<Object?> get props => [article];
}

class NewsError extends NewsState {
  final String message;

  NewsError(this.message);
  
  @override
  List<Object?> get props => [message];
}
