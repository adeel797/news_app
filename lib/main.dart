import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/app/app.bottomsheets.dart';
import 'package:news_app/app/app.dialogs.dart';
import 'package:news_app/app/app.locator.dart';
import 'package:news_app/app/app.router.dart';
import 'package:news_app/services/theme_service.dart';
import 'package:news_app/themes/dark_mode.dart';
import 'package:news_app/themes/light_mode.dart';
import 'package:stacked_services/stacked_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set up dependency injection
  await setupLocator();

  // Load theme
  final themeService = locator<ThemeService>();
  await themeService.loadTheme();

  // Set system UI overlay style based on theme
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: themeService.isDarkMode
          ? Brightness.light
          : Brightness.dark,
      systemNavigationBarColor: themeService.isDarkMode
          ? Colors.grey[900]
          : Colors.white,
      systemNavigationBarIconBrightness: themeService.isDarkMode
          ? Brightness.light
          : Brightness.dark,
    ),
  );

  // Set up dialogs and bottom sheets
  setupDialogUi();
  setupBottomSheetUi();

  runApp(MainApp(themeService: themeService));
}

class MainApp extends StatelessWidget {
  final ThemeService themeService;
  const MainApp({super.key, required this.themeService});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeService.themeNotifier,
      builder: (context, mode, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightMode,
          darkTheme: darkMode,
          themeMode: mode,
          initialRoute: Routes.startupView,
          onGenerateRoute: StackedRouter().onGenerateRoute,
          navigatorKey: StackedService.navigatorKey,
          navigatorObservers: [StackedService.routeObserver],
        );
      },
    );
  }
}