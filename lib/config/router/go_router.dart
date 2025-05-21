import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/screens/auth/login_screen.dart';
import 'package:vet_mobile_app/screens/auth/register_screen.dart';
import 'package:vet_mobile_app/screens/auth/forgot_password_screen.dart';
import 'package:vet_mobile_app/screens/auth/reset_password_screen.dart';
import 'package:vet_mobile_app/screens/menu/about_us.dart';
import 'package:vet_mobile_app/screens/menu/feed_screen.dart';
import 'package:vet_mobile_app/screens/menu/menu_screen.dart';
import 'package:vet_mobile_app/screens/menu/news_screen.dart';
import 'package:vet_mobile_app/screens/profile/edit_profile_screen.dart';
import 'package:vet_mobile_app/screens/settings_screen.dart';
import 'package:vet_mobile_app/screens/splash/splash_screen.dart';
import 'package:vet_mobile_app/screens/profile/profile_screen.dart' as profile;
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/screens/menu/topic_detail_screen.dart'; // Added import for TopicDetailScreen
import 'package:vet_mobile_app/screens/menu/diseases_screen.dart'; // Import for DiseasesScreen
import 'package:vet_mobile_app/screens/menu/cattle_screen.dart'; // ADDED
import 'package:vet_mobile_app/screens/menu/insemination_screen.dart'; // ADDED
import 'package:vet_mobile_app/screens/menu/sheep_goats_screen.dart'; // ADDED
import 'package:vet_mobile_app/screens/menu/horses_screen.dart'; // ADDED
import 'package:vet_mobile_app/screens/menu/chicken_screen.dart'; // ADDED

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: RouteNames.splash,
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
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
      ),
    ),
    GoRoute(
      path: RouteNames.feed, // Мисалы FeedScreen үчүн
      builder: (context, state) => const FeedScreen(),
    ),
    
    GoRoute(
      path: RouteNames.diseases, // DiseasesScreen үчүн (RouteNames'те да кошуңуз)
      builder: (context, state) => const DiseasesScreen(),
    ),
    GoRoute(
      path: RouteNames.insemination,
      builder: (context, state) => const InseminationScreen(), // UPDATED
    ),
    GoRoute(
      path: RouteNames.cattle, // This one is already correct
      builder: (context, state) => const CattleScreen(), // UPDATED
    ),
    GoRoute(
      path: RouteNames.goats,
      builder: (context, state) => const SheepGoatsScreen(),
    ),
    GoRoute(
      path: RouteNames.horses,
      builder: (context, state) => const HorsesScreen(),
    ),
    GoRoute(
      path: RouteNames.chicken,
      builder: (context, state) => const ChickenScreen(),
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
      name: RouteNames.editProfileScreen,
      path: RouteNames.editProfileScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const EditProfileScreen();
      },
    ),
    GoRoute(
      path: RouteNames.profile,
      builder: (context, state) {
        return const profile.ProfileScreen();
      },
    ),
    GoRoute(
      path: '/news',
      name: RouteNames.news,
      // Provide the appropriate index for the News tab in your BottomBar.
      // For example, if "News" is the second item (index 1):
      builder: (context, state) => const NewsScreen(bottomBarCurrentIndex: 1),
    ),
    GoRoute(
      path: '/topicDetail',
      name: RouteNames.topicDetail,
      builder: (context, state) {
        if (state.extra is Map<String, dynamic>) {
          final data = state.extra as Map<String, dynamic>;
          final topic = data['topic'] as TopicListItemModel?;
          final currentIndex = data['currentIndex'] as int?;

          if (topic != null && currentIndex != null) {
            return TopicDetailScreen(topic: topic, bottomBarCurrentIndex: currentIndex);
          } else {
            print("Error: 'topic' or 'currentIndex' is missing in state.extra for TopicDetailScreen.");
            return Scaffold(
              appBar: AppBar(title: const Text("Error")),
              body: const Center(child: Text("Could not load topic details. Data missing.")),
            );
          }
        } else {
          print("Error: Invalid data type passed to TopicDetailScreen route. Expected Map, got ${state.extra.runtimeType}");
          return Scaffold(
            appBar: AppBar(title: const Text("Error")),
            body: const Center(child: Text("Error loading page. Invalid navigation parameters.")),
          );
        }
      },
    ),
  ],
);
