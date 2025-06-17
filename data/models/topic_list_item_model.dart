class TopicListItemModel {
  final String id;
  final String imagePath;
  final String title;
  final String description;
  final String fullDescription;
  // final DateTime? publishedDate; // АЛЫНЫП САЛЫНДЫ

  TopicListItemModel({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.description,
    required this.fullDescription,
    // this.publishedDate, // АЛЫНЫП САЛЫНДЫ
  });
}
