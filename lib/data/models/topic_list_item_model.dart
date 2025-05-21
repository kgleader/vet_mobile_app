class TopicListItemModel {
  final String id;
  final String imagePath;
  final String title;
  final String description;
  final String fullDescription;

  const TopicListItemModel({
    required this.id, // 'required' keyword makes it mandatory
    required this.imagePath,
    required this.title,
    required this.description,
    required this.fullDescription, // 'required' keyword makes it mandatory
  });
}