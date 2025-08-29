import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:news_app/common/app_theme.dart';
import 'package:news_app/features/categories/view/screens/home_screen.dart';
import 'package:news_app/features/search_for_article/view/screens/search_screen.dart';
import 'package:news_app/features/search_for_article/view_model/search_view_model_provider.dart';
import 'package:news_app/providers/localization_provider.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

import 'common/app_prefs.dart';
import 'common/dependency_injection.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  await AppPrefs.init();
  // caching localization(shared preference)
  final localizationProvider = LocalizationProvider();
  await localizationProvider.localizationGetBool();
  //caching theme(shared preference)
  final themeProvider = ThemeProvider();
  await themeProvider.themeGetBool();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
      ChangeNotifierProvider<LocalizationProvider>.value(
          value: localizationProvider),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],
      locale: Locale(context.watch<LocalizationProvider>().appLocalization),
      routes: {
        HomeScreen.routeName: (_) => const HomeScreen(),
        SearchScreen.routeName: (_) => ChangeNotifierProvider(
            create: (context) => SearchViewModelProvider(),
            child: const SearchScreen()),
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: context.watch<ThemeProvider>().themeMode,
      initialRoute: HomeScreen.routeName,
    );
  }
}
