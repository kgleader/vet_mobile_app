import 'package:flutter/foundation.dart';

@immutable // Класстын объекттери өзгөрүлбөс (immutable) экенин билдирет
class MenuItemModel {
  final String title;      // Меню пунктунун аталышы
  final String iconPath;   // SVG иконкасынын жолу (мисалы, 'assets/icons/menu/feed.svg')
  final String route;      // Навигация үчүн маршрут (мисалы, RouteNames.feed)

  const MenuItemModel({
    required this.title,
    required this.iconPath,
    required this.route,
  });

  // Объекттерди салыштыруу үчүн (мисалы, тизмелерде же Set'терде колдонууда)
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true; // Эгер бир эле объект болсо, true кайтарат

    return other is MenuItemModel && // Эгер 'other' да MenuItemModel болсо
        other.title == title &&       // жана бардык талаалары бирдей болсо, true кайтарат
        other.iconPath == iconPath &&
        other.route == route;
  }

  // Хэш-код, объекттерди коллекцияларда (мисалы, Map же Set) туура иштеши үчүн керек
  // Эгер == оператору кайра аныкталса, hashCode да кайра аныкталышы керек
  @override
  int get hashCode => title.hashCode ^ iconPath.hashCode ^ route.hashCode;

  // Класстын объектин String түрүндө ыңгайлуу көрсөтүү үчүн (мисалы, лог жазууда)
  @override
  String toString() {
    return 'MenuItemModel(title: $title, iconPath: $iconPath, route: $route)';
  }

  // Объекттин көчүрмөсүн түзүп, айрым талааларын өзгөртүүгө мүмкүндүк берет
  // Бул immutable класстар менен иштөөдө абдан пайдалуу
  MenuItemModel copyWith({
    String? title,    // Эгер жаңы title берилсе, аны колдонот, болбосо эскисин калтырат
    String? iconPath, // Эгер жаңы iconPath берилсе, аны колдонот, болбосо эскисин калтырат
    String? route,    // Эгер жаңы route берилсе, аны колдонот, болбосо эскисин калтырат
  }) {
    return MenuItemModel(
      title: title ?? this.title,
      iconPath: iconPath ?? this.iconPath,
      route: route ?? this.route,
    );
  }
}