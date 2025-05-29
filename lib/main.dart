import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/app/theme.dart';
import 'package:weather_app/core/services/navigation_service.dart';
import 'package:weather_app/core/utils/location_util.dart';
import 'package:weather_app/src/controllers/theme_controller.dart';
import 'package:weather_app/src/controllers/weather_controller.dart';
import 'package:weather_app/src/models/shared_prefs_model.dart';
import 'package:weather_app/src/models/weather_model.dart';
import 'package:weather_app/src/views/current_view.dart';
import 'package:weather_app/src/views/forecast_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Future<SharedPreferences> _futureShared = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: _futureShared,
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox.shrink();
        }

        SharedPreferences shared = snapshot.data!;

        return MultiProvider(
            providers: [
              Provider<SharedPrefsModel>.value(value: SharedPrefsModel(shared: shared)),
              Provider<NavigationService>.value(value: NavigationService()),
              Provider<WeatherModel>.value(value: WeatherModel()),
              Provider<LocationUtil>.value(value: LocationUtil()),
              ChangeNotifierProvider(create: (context) => ThemeController(shared: context.read()),),
              ChangeNotifierProvider(create: (context) => WeatherController(
                weatherModel: context.read(),
                locationUtil: context.read(),
                sharedPrefsModel: context.read()
              )..getForecast(),)
            ],
            child: Consumer<ThemeController>(
              builder: (context, themeController, child) {
                return Consumer<NavigationService>(
                    builder: (context, navigationService, child) {
                      return MaterialApp(
                        navigatorKey: navigationService.navigatorKey,
                        title: 'Flutter Demo',
                        debugShowCheckedModeBanner: false,
                        theme: themeController.getTheme() ? darkTheme : lightTheme,
                        home: CurrentView(),
                      );
                    });
              }
            )
        );
      },
    );
  }
}
