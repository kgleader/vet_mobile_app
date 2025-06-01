class NewsItem {
  final String title;
  final String summary;
  final String imageUrl;
  final String date;
  final String? content;

  NewsItem({
    required this.title,
    required this.summary,
    required this.imageUrl,
    required this.date,
    this.content,
  });
}
