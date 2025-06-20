import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/app/theme.dart';
import 'package:weather_app/core/services/navigation_service.dart';
import 'package:weather_app/core/utils/location_util.dart';
import 'package:weather_app/l10n/l10n.dart';
import 'package:weather_app/src/controllers/language_controller.dart';
import 'package:weather_app/src/controllers/theme_controller.dart';
import 'package:weather_app/src/controllers/weather_controller.dart';
import 'package:weather_app/src/models/shared_prefs_model.dart';
import 'package:weather_app/src/models/weather_model.dart';
import 'package:weather_app/src/views/current_view.dart';
import 'package:weather_app/src/views/forecast_view.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              Provider<WeatherModel>.value(value: WeatherModel()),
              Provider<LocationUtil>.value(value: LocationUtil()),
              Provider<NavigationService>(create: (context) => NavigationService(),),
              ChangeNotifierProvider(create: (context) => LanguageController(),),
              ChangeNotifierProvider(create: (context) => ThemeController(shared: context.read()),),
              ChangeNotifierProvider(create: (context) => WeatherController(
                weatherModel: context.read(),
                locationUtil: context.read(),
                sharedPrefsModel: context.read(),
                navigationService: context.read(),
              )..getForecast(),)
            ],
            child: Consumer<LanguageController>(
              builder: (context, languageController, child) {
                return Consumer<ThemeController>(
                  builder: (context, themeController, child) {
                    return Consumer<NavigationService>(
                        builder: (context, navigationService, child) {
                          return MaterialApp(
                            locale: languageController.locale,
                            supportedLocales: L10n.all,
                            localizationsDelegates: [
                              AppLocalizations.delegate,
                              GlobalMaterialLocalizations.delegate,
                              GlobalWidgetsLocalizations.delegate,
                              GlobalCupertinoLocalizations.delegate
                            ],
                            navigatorKey: navigationService.navigatorKey,
                            title: 'Flutter Demo',
                            debugShowCheckedModeBanner: false,
                            theme: themeController.getTheme() ? darkTheme : lightTheme,
                            home: CurrentView(),
                          );
                        });
                  }
                );
              }
            )
        );
      },
    );
  }
}
