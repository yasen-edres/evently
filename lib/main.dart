import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events/auth/login/login_screen.dart';
import 'package:events/auth/register/register_screen.dart';
import 'package:events/home/add_event/add_event.dart';
import 'package:events/home/home_screen.dart';
import 'package:events/providers/app_language_provider.dart';
import 'package:events/providers/app_theme_provider.dart';
import 'package:events/ui/onboarding/onboarding_screen.dart';
import 'package:events/utils/app_routes.dart';
import 'package:events/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); //sure all initialize before run app.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseFirestore.instance.disableNetwork(); //todo: offline
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppLanguageProvider()),
        ChangeNotifierProvider(create: (context) => AppThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<AppLanguageProvider>(context);
    var themeProvider = Provider.of<AppThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoute.loginRouteName,
      routes: {
        AppRoute.onboardingScreen: (context) => (OnboardingScreen()),
        AppRoute.homeRouteName: (context) => (HomeScreen()),
        AppRoute.loginRouteName: (context) => (LoginScreen()),
        AppRoute.registerRouteName: (context) => (RegisterScreen()),
        AppRoute.addEventRouteName: (context) => (AddEvent()),
      },
      locale: Locale(languageProvider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeProvider.appTheme,
    );
  }
}
