import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'config/router/go_router.dart';
import 'config/theme/app_theme.dart';
import 'package:vet_mobile_app/blocs/vet_profile/vet_profile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase with the proper options, only if no app has been initialized
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  
  // Run the app
  runApp(const VetMobileApp());
}

class VetMobileApp extends StatelessWidget {
  const VetMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<VetProfileBloc>(
          create: (context) => VetProfileBloc(),
        ),
        // ... другие BLoC провайдеры
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'Vet Mobile App',
        theme: AppTheme.lightTheme,
        // Локализация делегаттарын кайра кошобуз
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          // Эгер өзүңүздүн AppLocalizations колдонсоңуз, аны да бул жерге кошосуз:
          // AppLocalizations.delegate, 
        ],
        supportedLocales: const [
          Locale('ky', ''), // Кыргыз тили
          Locale('ru', ''), // Орус тили
          // Башка колдоого алынган тилдерди бул жерге кошуңуз
          // Мисалы, англис тили демейки Material компоненттери үчүн:
          Locale('en', ''),
        ],
        // locale: const Locale('ky', ''), // Демейки тилди орнотуу (милдеттүү эмес, системанын тилин колдонсо болот)
      ),
    );
  }
}