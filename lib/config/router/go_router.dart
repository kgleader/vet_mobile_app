import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vet_mobile_app/data/models/topic_list_item_model.dart';
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
import 'package:vet_mobile_app/config/router/route_names.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  initialLocation: RouteNames.splash,
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
      ),
    ),
    GoRoute(
      path: RouteNames.feed,
      builder: (context, state) => CategoryScreen(
        title: 'Тоют',
        bannerImagePath: 'assets/images/grass_banner.svg',
        topicItems: [
          TopicListItemModel(
            imagePath: 'assets/images/feed_topic1.svg',
            title: 'Негизги тоюттар',
            description: 'Уйлар, койлор жана башка малдар үчүн негизги тоют түрлөрү.',
          ),
          TopicListItemModel(
            imagePath: 'assets/images/feed_topic2.svg',
            title: 'Атайын кошулмалар',
            description: 'Витаминдер, минералдар жана башка пайдалуу кошулмалар.',
          ),
          TopicListItemModel(
            imagePath: 'assets/images/feed_topic3.svg',
            title: 'Жайкы тоюттандыруу',
            description: 'Жай мезгилиндеги мал багуу жана тоюттандыруу өзгөчөлүктөрү.',
          ),
        ],
      ),
    ),
    GoRoute(
      path: RouteNames.male,
      builder: (context, state) => CategoryScreen(
        title: 'Уруктандыруу',
        bannerImagePath: 'assets/images/breeding_banner.svg', // Placeholder
        topicItems: [
          TopicListItemModel(
            imagePath: 'assets/images/natural_breeding.svg', // Placeholder
            title: 'Табигый уруктандыруу',
            description: 'Малды табигый жол менен уруктандыруу ыкмалары жана өзгөчөлүктөрү.',
          ),
          TopicListItemModel(
            imagePath: 'assets/images/artificial_insemination.svg', // Placeholder
            title: 'Жасалма уруктандыруу',
            description: 'Заманбап технологияларды колдонуу менен жасалма уруктандыруу.',
          ),
          TopicListItemModel(
            imagePath: 'assets/images/breeding_tech.svg', // Placeholder
            title: 'Уруктандыруу технологиялары',
            description: 'Уруктандыруу процессиндеги жаңы технологиялар жана ыкмалар.',
          ),
        ],
      ),
    ),
    GoRoute(
      path: RouteNames.vaccines,
      builder: (context, state) => CategoryScreen(
        title: 'Оорулар',
        bannerImagePath: 'assets/images/diseases_banner.svg', // Placeholder
        topicItems: [
          TopicListItemModel(
            imagePath: 'assets/images/common_diseases.svg', // Placeholder
            title: 'Кеңири таралган оорулар',
            description: 'Мал арасында көп кездешкен оорулар жана алардын белгилери.',
          ),
          TopicListItemModel(
            imagePath: 'assets/images/disease_prevention.svg', // Placeholder
            title: 'Оорулардын алдын алуу',
            description: 'Профилактикалык чаралар жана эмдөөлөр.',
          ),
          TopicListItemModel(
            imagePath: 'assets/images/disease_treatment.svg', // Placeholder
            title: 'Ооруларды дарылоо',
            description: 'Ооруларды дарылоонун негизги ыкмалары жана каражаттары.',
          ),
        ],
      ),
    ),
    GoRoute(
      path: RouteNames.cattle,
      builder: (context, state) => CategoryScreen(
        title: 'Бодо мал',
        bannerImagePath: 'assets/images/cattle_banner.jpg', // Placeholder
        topicItems: [
          TopicListItemModel(
            imagePath: 'assets/images/cattle_breeds.jpg', // Placeholder
            title: 'Породалары',
            description: 'Бодо малдын негизги породалары жана алардын өзгөчөлүктөрү.',
          ),
          TopicListItemModel(
            imagePath: 'assets/images/cattle_care.jpg', // Placeholder
            title: 'Багуу жана кармоо',
            description: 'Бодо малды багуу, кармоо шарттары жана рацион түзүү.',
          ),
        ],
      ),
    ),
    GoRoute(
      path: RouteNames.goats,
      builder: (context, state) => CategoryScreen(
        title: 'Кой эчки',
        bannerImagePath: 'assets/images/goats_banner.jpg', // Placeholder
        topicItems: [
          TopicListItemModel(
            imagePath: 'assets/images/goats_breeds.jpg', // Placeholder
            title: 'Породалары',
            description: 'Кой-эчкилердин популярдуу породалары жана аларды тандоо.',
          ),
          TopicListItemModel(
            imagePath: 'assets/images/goats_care.jpg', // Placeholder
            title: 'Багуу жана кармоо',
            description: 'Кой-эчкилерди багуунун өзгөчөлүктөрү, жайыт жана тоюттандыруу.',
          ),
        ],
      ),
    ),
    GoRoute(
      path: RouteNames.horses,
      builder: (context, state) => CategoryScreen(
        title: 'Жылкылар',
        bannerImagePath: 'assets/images/horses_banner.jpg', // Placeholder
        topicItems: [
          TopicListItemModel(
            imagePath: 'assets/images/horses_breeds.jpg', // Placeholder
            title: 'Породалары',
            description: 'Жылкылардын негизги породалары жана алардын колдонулушу.',
          ),
          TopicListItemModel(
            imagePath: 'assets/images/horses_care.jpg', // Placeholder
            title: 'Багуу жана машыктыруу',
            description: 'Жылкыларды багуу, тазалоо, машыктыруу жана жабдыктар.',
          ),
        ],
      ),
    ),
    GoRoute(
      path: RouteNames.chicken,
      builder: (context, state) => CategoryScreen(
        title: 'Тоок',
        bannerImagePath: 'assets/images/chicken_banner.jpg', // Placeholder
        topicItems: [
          TopicListItemModel(
            imagePath: 'assets/images/chicken_breeds.jpg', // Placeholder
            title: 'Породалары',
            description: 'Тооктордун эт багытындагы, жумуртка багытындагы жана аралаш породалары.',
          ),
          TopicListItemModel(
            imagePath: 'assets/images/chicken_care.jpg', // Placeholder
            title: 'Багуу жана тоюттандыруу',
            description: 'Тоокторду багуу үчүн жай, тоюттандыруу жана оорулардын алдын алуу.',
          ),
        ],
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
      name: RouteNames.editProfileScreen,
      path: RouteNames.editProfileScreen,
      builder: (BuildContext context, GoRouterState state) {
        return const EditProfileScreen();
      },
    ),
  ],
);
