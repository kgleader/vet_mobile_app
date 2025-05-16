import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/data/models/menu_item_model.dart';

class MenuConstants {
  static const List<MenuItemModel> menuItems = [
    MenuItemModel(
      title: 'Биз жөнүндө',
      iconPath: 'about_us.svg',
      route: RouteNames.about,
    ),
    MenuItemModel(
      title: 'Тоют',
      iconPath: 'grass.svg',
      route: RouteNames.feed,
    ),
    MenuItemModel(
      title: 'Уруктандыруу',
      iconPath: 'male.svg',
      route: RouteNames.male,
    ),
    MenuItemModel(
      title: 'Оорулар',
      iconPath: 'vaccines.svg',
      route: RouteNames.vaccines,
    ),
    MenuItemModel(
      title: 'Бодо мал',
      iconPath: 'bodomal.svg',
      route: RouteNames.cattle,
    ),
    MenuItemModel(
      title: 'Кой эчки',
      iconPath: 'goats.svg',
      route: RouteNames.goats,
    ),
    MenuItemModel(
      title: 'Жылкылар',
      iconPath: 'horses.svg',
      route: RouteNames.horses,
    ),
    MenuItemModel(
      title: 'Тоок',
      iconPath: 'chicken.svg',
      route: RouteNames.chicken,
    ),
  ];
}