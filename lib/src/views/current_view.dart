import 'package:flutter/material.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/app/consts.dart';
import 'package:weather_app/core/services/navigation_service.dart';
import 'package:weather_app/core/utils/get_weather_icon_util.dart';
import 'package:weather_app/src/clean_features/entities/city_entity.dart';
import 'package:weather_app/src/clean_features/entities/current_entity.dart';
import 'package:weather_app/src/clean_features/entities/forecast_day_entity.dart';
import 'package:weather_app/src/clean_features/entities/hour_entity.dart';
import 'package:weather_app/src/clean_features/entities/location_entity.dart';
import 'package:weather_app/src/clean_features/widgets/current_weather_extra_info_widget.dart';
import 'package:weather_app/src/clean_features/widgets/current_weather_widget.dart';
import 'package:weather_app/src/clean_features/widgets/weather_tile_widget.dart';
import 'package:weather_app/src/controllers/language_controller.dart';
import 'package:weather_app/src/controllers/theme_controller.dart';
import 'package:weather_app/src/controllers/weather_controller.dart';
import 'package:weather_app/src/views/forecast_view.dart';

import '../../core/app/enums.dart';
import '../clean_features/dialogs/set_language_dialog.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CurrentView extends StatefulWidget {
  CurrentView({super.key});

  @override
  State<CurrentView> createState() => _CurrentViewState();
}

class _CurrentViewState extends State<CurrentView> {
  HourEntity? selectedHour;

  @override
  Widget build(BuildContext context) {
    WeatherController weatherController = context.watch();
    ThemeController themeController = context.watch();
    final textTheme = Theme.of(context).textTheme;

    LocationEntity? location = weatherController.weather?.location;
    CurrentEntity? current = weatherController.weather?.current;

    return weatherController.weather == null
    ? Center(child: const CircularProgressIndicator())
    : Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.location_on_outlined, size: 24,),
            const Gap(5),
            Text("${location!.name} - ${location.country}", style: textTheme.titleMedium,)
          ],
        ),
        actions: [
          // Lenguaje
          IconButton(
            onPressed: () => setLanguage(context),
            icon: Icon(Icons.language_outlined, size: 24,)
          ),
          // Busqueda
          IconButton(
            onPressed: () => setLocation(context),
            icon: Icon(Icons.search_outlined, size: 24,)
          ),
          // Tema
          Switch(
            value: themeController.getTheme(),
            onChanged: (value) async {
              await themeController.saveTheme(value);
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [

            // Clima Actual | Card
            CurrentWeatherWidget(
              title: selectedHour != null ? selectedHour!.condition.text : current!.condition.text,
              temperature: selectedHour != null ? selectedHour!.tempC.toStringAsFixed(0) : current!.feelslikeC.toStringAsFixed(0),
              date: DateTime.now(),
              icon: getWeatherIconWithEnumUtil(
                iconEnum: selectedHour != null ? selectedHour!.condition.code : current!.condition.code,
                isDark: themeController.getTheme()
              ).fold(
                (l) => throw UnimplementedError(),
                (r) => r,
              )
            ),

            // Clima actual | Información extra
            const Gap(10),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CurrentWeatherExtraInfoWidget(
                  icon: Icons.air_outlined,
                  title: "${selectedHour != null ? selectedHour!.gustKph : weatherController.weather!.current.gustKph} km/h",
                  description: AppLocalizations.of(context)!.wind
                ),
                SizedBox(
                  height: 80,
                  child: VerticalDivider(color: AppColors.neutralGrey,)
                ),
                CurrentWeatherExtraInfoWidget(
                  icon: MaterialSymbols.humidity_percentage_filled,
                  title: "${selectedHour != null ? selectedHour!.humidity : weatherController.weather!.current.humidity}%",
                  description: AppLocalizations.of(context)!.humidity
                )
              ],
            ),

            const Gap(10),

            // Botón de pronostico
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.today),
                TextButton(
                    onPressed: () => goToForecastView(context),
                    child: Row(
                      children: [
                        Text(AppLocalizations.of(context)!.seven_days),
                        Icon(Icons.arrow_forward_ios_outlined)
                      ],
                    )
                )
              ],
            ),

            const Gap(10),

            // Lista de clima por Hora
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(bottom: 75),
                itemCount: weatherController.weather!.forecast.forecastday.first.hour.length,
                separatorBuilder: (context, index) => Gap(10),
                itemBuilder: (context, index) {
                  ForecastDayEntity forecast = weatherController.weather!.forecast.forecastday.first;
                  HourEntity hour = forecast.hour[index];

                  return WeatherTileWidget(
                    onTap: () {
                      if (selectedHour == hour) {
                        selectedHour = null;
                      }
                      else {
                        selectedHour = hour;
                      }
                      setState(() {});
                    },
                    selected: selectedHour == hour,
                    leading: "${DateFormat("hh:mm a").format(DateTime.parse(hour.time))}",
                    trailing: "${hour.tempC}",
                    icon: getWeatherIconWithEnumUtil(
                      iconEnum: hour.condition.code,
                      isDark: themeController.getTheme()
                    ).fold((l) => throw UnimplementedError(), (r) => r,)
                  );
                },
              ),
            )


          ],
        ),
      ),
    );
  }

  void goToForecastView(BuildContext context) {
   // todo: Navegar a Forecast View con un servicio
    NavigationService navigationService = context.read();
    navigationService.navigateTo(ForecastView());
  }

  void setLanguage(BuildContext context) async {
    LanguageController languageController = context.read();

    LanguageTypes? language = await showDialog(
      context: context,
      builder: (context) => SetLanguageDialog(),
    );

    if (language != null) {
      languageController.changeLocale(language.code);
    }

  }

  void setLocation(BuildContext context) {
    showSearch(
      context: context,
      delegate: CustomSearch()
    );
  }

}

class CustomSearch extends SearchDelegate {

  @override
  // TODO: implement searchFieldLabel
  String? get searchFieldLabel => "Buscar";

  @override
  // TODO: implement searchFieldDecorationTheme
  InputDecorationTheme? get searchFieldDecorationTheme => InputDecorationTheme(
    hintStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
    border: OutlineInputBorder(borderSide: BorderSide.none)
  );

  @override
  // TODO: implement searchFieldStyle
  TextStyle? get searchFieldStyle => TextStyle(color: Colors.red);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return null;
  }

  @override
  Widget? buildLeading(BuildContext context) {
   return null;
  }

  @override
  Widget buildResults(BuildContext context) {

    WeatherController weatherController = context.read();
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    TextTheme textTheme = Theme.of(context).textTheme;

    return FutureBuilder(
      future: weatherController.searchCity(query),
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        }

        List<CityEntity> cities = snapshot.data!;

        return ListView.separated(
          itemCount: cities.length,
          separatorBuilder: (context, index) {
            return SizedBox(height: 10,);
          },
          itemBuilder: (context, index) {

            CityEntity city = cities[index];

            return ListTile(
              title: Text("${city.name}, ${city.region}", style: textTheme.titleMedium,),
              trailing: Text(city.country),
              tileColor: colorScheme.surface,
              onTap: () async {
                await weatherController.getForecastWithCoords(city);
              },
            );
          },
        );
      },
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return SizedBox.shrink();
  }

}
