// This file is the main entry point of the application. It initializes Firebase, sets up the main app widget, and configures routing, theming, and localization.
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
  
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  
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
      ],
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,
        title: 'Vet Mobile App',
        theme: AppTheme.lightTheme,
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ky', ''), 
          Locale('ru', ''), 
          Locale('en', ''),
        ],
      ),
    );
  }
}