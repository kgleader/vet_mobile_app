import 'package:vet_mobile_app/data/models/news_article.dart';

abstract class NewsState {
  const NewsState();
}

class NewsInitial extends NewsState {
  const NewsInitial();
}

class NewsLoading extends NewsState {
  const NewsLoading();
}

class NewsLoaded extends NewsState {
  const NewsLoaded(this.articles);
  final List<NewsArticle> articles;
}

class NewsError extends NewsState {
  const NewsError(this.message);
  final String message;
}
