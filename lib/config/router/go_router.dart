import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/blocs/navigation/navigation_bloc.dart';
import 'package:vet_mobile_app/blocs/news/news_bloc.dart';
import 'package:vet_mobile_app/blocs/news/news_event.dart';
import 'package:vet_mobile_app/blocs/vet_profile/vet_profile_bloc.dart';
import 'package:vet_mobile_app/layouts/main_layout.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
import 'package:vet_mobile_app/screens/auth/login_screen.dart';
import 'package:vet_mobile_app/screens/auth/register_screen.dart';
import 'package:vet_mobile_app/screens/auth/forgot_password_screen.dart';
import 'package:vet_mobile_app/screens/auth/reset_password_screen.dart';
import 'package:vet_mobile_app/screens/menu/about_us.dart';
import 'package:vet_mobile_app/screens/menu/cattle_diseases_screen.dart';
import 'package:vet_mobile_app/screens/menu/cattle_insemination_screen.dart';
import 'package:vet_mobile_app/screens/menu/feed_screen.dart';
import 'package:vet_mobile_app/screens/menu/menu_screen.dart';
import 'package:vet_mobile_app/screens/menu/news_screen.dart';
import 'package:vet_mobile_app/screens/profile/edit_profile_screen.dart';
import 'package:vet_mobile_app/screens/settings_screen.dart';
import 'package:vet_mobile_app/screens/splash/splash_screen.dart';
import 'package:vet_mobile_app/screens/profile/profile_screen.dart' as profile;
import 'package:vet_mobile_app/config/router/route_names.dart';
import 'package:vet_mobile_app/screens/menu/topic_detail_screen.dart';
import 'package:vet_mobile_app/screens/menu/diseases_screen.dart';
import 'package:vet_mobile_app/screens/menu/cattle_screen.dart';
import 'package:vet_mobile_app/screens/menu/insemination_screen.dart';
import 'package:vet_mobile_app/screens/menu/sheep_goats_screen.dart';
import 'package:vet_mobile_app/screens/menu/horses_screen.dart';
import 'package:vet_mobile_app/screens/menu/chicken_screen.dart';
import 'package:vet_mobile_app/screens/menu/sheep_feeding_screen.dart';
import 'package:vet_mobile_app/screens/menu/sheep_diseases_screen.dart';
import 'package:vet_mobile_app/screens/menu/sheep_insemination_screen.dart';
import 'package:vet_mobile_app/screens/vet/veterinar_screen.dart';
import 'package:vet_mobile_app/screens/vet/vet_message.dart';
import 'package:vet_mobile_app/screens/vet/vet_message_success_screen.dart';
import 'package:vet_mobile_app/screens/vet/vet_message_failure_screen.dart';
import 'package:vet_mobile_app/data/models/vet_model.dart';
import 'package:vet_mobile_app/screens/menu/horse_feeding_screen.dart';
import 'package:vet_mobile_app/screens/menu/horse_diseases_screen.dart';
import 'package:vet_mobile_app/screens/menu/chicken_feeding_screen.dart';
import 'package:vet_mobile_app/screens/menu/chicken_diseases_screen.dart';


final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

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
    
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => BlocProvider(
        create: (context) => NavigationBloc(),
        child: MainLayout(child: child),
      ),
      routes: [
        GoRoute(
          path: RouteNames.menu, 
          builder: (context, state) => const MenuScreen(),
          routes: [
            GoRoute(
              path: 'feed',
              builder: (context, state) => const FeedScreen(),
            ),
            GoRoute(
              path: 'about',
              builder: (context, state) => const AboutUsScreen(title: 'Биз жөнүндө'),
            ),
            GoRoute(
              path: 'diseases',
              builder: (context, state) => const DiseasesScreen(bottomBarCurrentIndex: 0),
            ),
            GoRoute(
              path: 'insemination',
              builder: (context, state) => const InseminationScreen(),
            ),
            GoRoute(
              path: 'cattle', 
              name: RouteNames.cattle,
              builder: (context, state) => const CattleScreen(),
            ),
            GoRoute(
              path: 'goats', 
              name: RouteNames.goats,
              builder: (context, state) => const SheepGoatsScreen(),
              routes: [
                GoRoute(
                  path: 'feeding', 
                  name: RouteNames.sheepFeeding, 
                  builder: (context, state) => const SheepFeedingScreen(),
                ),
                GoRoute(
                  path: 'diseases', 
                  name: RouteNames.sheepDiseases, 
                  builder: (context, state) => const SheepDiseasesScreen(),
                ),
                GoRoute(
                  path: 'insemination', 
                  name: RouteNames.sheepInsemination, 
                  builder: (context, state) => const SheepInseminationScreen(),
                ),
              ]
            ),
            GoRoute(
              path: 'horses', 
              name: RouteNames.horses, 
              builder: (context, state) => const HorsesScreen(),
              routes: [ 
                GoRoute(
                  path: 'feeding', 
                  name: RouteNames.horseFeeding,
                  builder: (context, state) => const HorseFeedingScreen(), 
                ),
                GoRoute(
                  path: 'diseases', 
                  name: RouteNames.horseDiseases,
                  builder: (context, state) => const HorseDiseasesScreen(), 
                ),
                GoRoute(
                  path: 'insemination', 
                  name: RouteNames.horseInsemination,
                  builder: (context, state) => const Scaffold(body: Center(child: Text("Horse Insemination Screen Placeholder"))), 
                ),
              ]
            ),
          ],
        ),
        GoRoute(
          path: '/news',
          name: 'news_screen',
          builder: (context, state) {
            return BlocProvider(
              create: (context) => NewsBloc()..add(LoadNews()),
              child: const NewsScreen(),
            );
          },
        ),
        GoRoute(
          path: RouteNames.vetList, 
          name: RouteNames.vetList,
          pageBuilder: (context, state) {
            const String defaultVetId = 'vet_asanov'; 
            return CustomTransitionPage(
              key: state.pageKey,
              child: BlocProvider<VetProfileBloc>( 
                create: (context) => VetProfileBloc(),
                child: const VeterinarScreen(vetId: defaultVetId),
              ), 
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(opacity: animation, child: child);
              },
            );
          },
          routes: [
            GoRoute(
              path: 'message',
              name: RouteNames.vetMessage,
              builder: (context, state) {
                if (state.extra is Map<String, dynamic>) {
                  final data = state.extra as Map<String, dynamic>;
                  if (data.containsKey('vet') && data['vet'] is VetModel) {
                    final vet = data['vet'] as VetModel;
                    return VetMessage(vet: vet);
                  }
                }
                return const Scaffold(body: Center(child: Text("Ветеринар маалыматы жетишсиз"))); 
              },
            ),
          ],
        ),
        GoRoute(
          path: RouteNames.chicken, 
          name: RouteNames.chicken,
          builder: (context, state) => const ChickenScreen(),
          routes: [
            GoRoute(
              path: 'feeding', // Бул /chicken/feeding жолун түзөт
              name: RouteNames.chickenFeeding,
              builder: (context, state) => const ChickenFeedingScreen(),
            ),
            GoRoute(
              path: 'diseases', // Бул /chicken/diseases жолун түзөт
              name: RouteNames.chickenDiseases, // Аталышын текшериңиз
              builder: (context, state) => const ChickenDiseasesScreen(), // Жаңы экран
            ),
          ]
        ),
        GoRoute(
          path: '/cattle_feed', // Мурунку
          name: RouteNames.cattleFeed,
          builder: (context, state) => const FeedScreen(),
        ),
        GoRoute(
          path: '/cattle_diseases', // Жаңы URL дареги
          name: RouteNames.cattleDiseases,
          builder: (context, state) => const CattleDiseasesScreen(), // Жаңы экран
        ),
        GoRoute(
          path: '/cattle_insemination', // Мурунку
          name: RouteNames.cattleInsemination,
          builder: (context, state) => const CattleInseminationScreen(),
        ),
        // ТӨМӨНКҮ БӨЛҮКТҮ ӨЧҮРҮҢҮЗ -----
        // GoRoute(
        //   path: '/chicken_feeding', // Жаңы URL дареги
        //   name: RouteNames.chickenFeeding,
        //   builder: (context, state) => const ChickenFeedingScreen(), // Жаңы экран
        // ),
        // ----- ӨЧҮРҮЛҮҮЧҮ БӨЛҮКТҮН АЯГЫ
      ],
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
      name: RouteNames.vetMessageSuccess,
      path: RouteNames.vetMessageSuccess,
      builder: (context, state) => const VetMessageSuccessScreen(),
    ),
    GoRoute(
      name: RouteNames.vetMessageFailure,
      path: RouteNames.vetMessageFailure,
      builder: (context, state) => const VetMessageFailureScreen(),
    ),
  ],
);
