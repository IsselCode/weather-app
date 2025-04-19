import 'package:flutter/material.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/app/consts.dart';
import 'package:weather_app/core/services/navigation_service.dart';
import 'package:weather_app/core/utils/get_weather_icon_util.dart';
import 'package:weather_app/src/clean_features/entities/current_entity.dart';
import 'package:weather_app/src/clean_features/entities/location_entity.dart';
import 'package:weather_app/src/clean_features/widgets/current_weather_extra_info_widget.dart';
import 'package:weather_app/src/clean_features/widgets/current_weather_widget.dart';
import 'package:weather_app/src/clean_features/widgets/weather_tile_widget.dart';
import 'package:weather_app/src/controllers/weather_controller.dart';
import 'package:weather_app/src/views/forecast_view.dart';

import '../../core/app/enums.dart';

class CurrentView extends StatelessWidget {
  const CurrentView({super.key});

  @override
  Widget build(BuildContext context) {
    WeatherController weatherController = context.watch();
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
          IconButton(
            onPressed: () => setLocation(context),
            icon: Icon(Icons.search_outlined, size: 24,)
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [

            // Clima Actual | Card
            CurrentWeatherWidget(
              title: current!.condition.text,
              temperature: current!.feelslikeC.toStringAsFixed(0),
              date: DateTime.now(),
              icon: getWeatherIconWithEnumUtil(
                iconEnum: WeatherIconEnum.snowy,
                isDark: false
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
                  title: "8km/h",
                  description: "Viento"
                ),
                SizedBox(
                  height: 80,
                  child: VerticalDivider(color: AppColors.neutralGrey,)
                ),
                CurrentWeatherExtraInfoWidget(
                  icon: MaterialSymbols.humidity_percentage_filled,
                  title: "22%",
                  description: "Humedad"
                )
              ],
            ),

            const Gap(10),

            // Botón de pronostico
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Hoy"),
                TextButton(
                    onPressed: () => goToForecastView(context),
                    child: Row(
                      children: [
                        Text("7 Días"),
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
                itemCount: 24,
                separatorBuilder: (context, index) => Gap(10),
                itemBuilder: (context, index) {
                  return WeatherTileWidget(
                    leading: "12:00",
                    trailing: "18",
                    icon: "assets/weather_icons/SnowyDark.png"
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

  void setLanguage(BuildContext context) {



  }

  void setLocation(BuildContext context) {

  }

}
