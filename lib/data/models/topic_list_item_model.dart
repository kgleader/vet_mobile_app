class TopicListItemModel {
  final String imagePath;
  final String title;
  final String description;
  // You might add other properties here if needed, e.g., a route to navigate to
  // final String? routeName;

  const TopicListItemModel({
    required this.imagePath,
    required this.title,
    required this.description,
    // this.routeName,
  });

  get routeName => null;
}