import 'package:equatable/equatable.dart';

// Events
abstract class NewsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadNewsEvent extends NewsEvent {}

class LoadNewsArticle extends NewsEvent {
  final String articleId;

  LoadNewsArticle({required this.articleId});
  
  @override
  List<Object?> get props => [articleId];
}