import 'package:flutter/foundation.dart';

@immutable
class MenuItemModel {
  final String title;      // Название пункта меню
  final String iconPath;   // Путь к SVG иконке
  final String route;      // Маршрут для навигации

  const MenuItemModel({
    required this.title,
    required this.iconPath,
    required this.route,
  });

  // Для сравнения объектов
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MenuItemModel &&
        other.title == title &&
        other.iconPath == iconPath &&
        other.route == route;
  }

  // Хэш-код для корректной работы в коллекциях
  @override
  int get hashCode => title.hashCode ^ iconPath.hashCode ^ route.hashCode;

  // Для отладки и логирования
  @override
  String toString() {
    return 'MenuItemModel(title: $title, iconPath: $iconPath, route: $route)';
  }

  // Создание копии с возможностью изменения полей
  MenuItemModel copyWith({
    String? title,
    String? iconPath,
    String? route,
  }) {
    return MenuItemModel(
      title: title ?? this.title,
      iconPath: iconPath ?? this.iconPath,
      route: route ?? this.route,
    );
  }
}