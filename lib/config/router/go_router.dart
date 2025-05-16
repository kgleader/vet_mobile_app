import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/screens/auth/login_screen.dart';
import 'package:vet_mobile_app/screens/auth/register_screen.dart';
import 'package:vet_mobile_app/screens/auth/forgot_password_screen.dart';
import 'package:vet_mobile_app/screens/auth/reset_password_screen.dart';
import 'package:vet_mobile_app/screens/menu/about_us.dart';
import 'package:vet_mobile_app/screens/menu/category_screen.dart';
import 'package:vet_mobile_app/screens/menu/menu_screen.dart';
import 'package:vet_mobile_app/screens/profile/edit_profile_screen.dart';
import 'package:vet_mobile_app/screens/settings_screen.dart';
import 'package:vet_mobile_app/screens/splash/splash_screen.dart';
import 'package:vet_mobile_app/screens/profile/profile_screen.dart' as profile;
import 'route_names.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/', // Reverted initial location to SplashScreen
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: RouteNames.profile,
      builder: (context, state) => const profile.ProfileScreen(),
    ),
    GoRoute(
      path: RouteNames.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RouteNames.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: RouteNames.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: RouteNames.forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: RouteNames.menu,
      builder: (context, state) => const MenuScreen(),
    ),
    GoRoute(
      path: RouteNames.about,
      builder: (context, state) => const AboutUsScreen(
        title: 'Биз жөнүндө',
        iconPath: 'about_us.svg',
      ),
    ),
    GoRoute(
      path: RouteNames.feed,
      builder: (context, state) => const CategoryScreen(
        title: 'Тоют',
        iconPath: 'grass.svg',
        topics: ['Корма для КРС', 'Специальные добавки', 'Летний откорм'],
      ),
    ),
    GoRoute(
      path: RouteNames.male,
      builder: (context, state) => const CategoryScreen(
        title: 'Уруктандыруу',
        iconPath: 'male.svg',
        topics: ['Естественная случка', 'Искусственное осеменение', 'Технологии'],
      ),
    ),
    GoRoute(
      path: RouteNames.vaccines,
      builder: (context, state) => const CategoryScreen(
        title: 'Оорулар',
        iconPath: 'vaccines.svg',
        topics: ['Распространенные болезни', 'Профилактика', 'Лечение'],
      ),
    ),
    GoRoute(
      path: RouteNames.cattle,
      builder: (context, state) => const CategoryScreen(
        title: 'Бодо мал',
        iconPath: 'bodomal.svg',
        topics: ['Породы', 'Содержание', 'Разведение', 'Болезни'],
      ),
    ),
    GoRoute(
      path: RouteNames.goats,
      builder: (context, state) => const CategoryScreen(
        title: 'Кой эчки',
        iconPath: 'goats.svg',
        topics: ['Породы', 'Содержание', 'Разведение', 'Болезни'],
      ),
    ),
    GoRoute(
      path: RouteNames.horses,
      builder: (context, state) => const CategoryScreen(
        title: 'Жылкылар',
        iconPath: 'horses.svg',
        topics: ['Породы', 'Содержание', 'Разведение', 'Болезни'],
      ),
    ),
    GoRoute(
      path: RouteNames.chicken,
      builder: (context, state) => const CategoryScreen(
        title: 'Тоок',
        iconPath: 'chicken.svg',
        topics: ['Породы', 'Содержание', 'Разведение', 'Болезни'],
      ),
    ),
    GoRoute(
      path: RouteNames.resetPassword,
      builder: (context, state) => const ResetPasswordScreen(),
    ),
    GoRoute(
      path: RouteNames.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(
      path: RouteNames.editProfileScreen,
      builder: (context, state) => const EditProfileScreen(),
    ),
  ],
);
