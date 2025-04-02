import 'package:flutter/material.dart';
import 'package:weather_app/core/app/theme.dart';
import 'package:weather_app/core/services/navigation_service.dart';
import 'package:weather_app/src/views/current_view.dart';
import 'package:weather_app/src/views/forecast_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    NavigationService navigationService = NavigationService();

    return MaterialApp(
      navigatorKey: navigationService.navigatorKey,
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: const CurrentView(),
    );
  }
}
