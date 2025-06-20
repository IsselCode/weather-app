import 'package:flutter/material.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/core/utils/get_weather_icon_util.dart';
import 'package:weather_app/src/clean_features/entities/forecast_day_entity.dart';
import 'package:weather_app/src/clean_features/widgets/current_weather_widget.dart';
import 'package:weather_app/src/controllers/theme_controller.dart';
import 'package:weather_app/src/controllers/weather_controller.dart';

import '../../core/app/consts.dart';
import '../clean_features/widgets/current_weather_extra_info_widget.dart';
import '../clean_features/widgets/weather_tile_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForecastView extends StatefulWidget {
  const ForecastView({super.key});

  @override
  State<ForecastView> createState() => _ForecastViewState();
}

class _ForecastViewState extends State<ForecastView> {

  late ForecastDayEntity selectedForecastDay;
  late WeatherController weatherController;

  @override
  void initState() {
    super.initState();
    weatherController = context.read();
    selectedForecastDay = weatherController.weather!.forecast.forecastday.first;
  }

  @override
  Widget build(BuildContext context) {
    ThemeController themeController = context.watch();
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(AppLocalizations.of(context)!.next_seven_days, style: textTheme.titleLarge,),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [

            CurrentWeatherWidget(
              title: selectedForecastDay.day.condition.text,
              temperature: selectedForecastDay.day.maxtempC.toStringAsFixed(0),
              date: selectedForecastDay.date,
              icon: getWeatherIconWithEnumUtil(
                iconEnum: selectedForecastDay.day.condition.code,
                isDark: themeController.getTheme()
              ).fold((l) => throw Exception(l.message), (r) => r,)
            ),

            const Gap(25),


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CurrentWeatherExtraInfoWidget(
                    icon: Icons.air_outlined,
                    title: "${selectedForecastDay.day.maxwindKph}km/h",
                    description: AppLocalizations.of(context)!.wind
                ),
                SizedBox(
                    height: 80,
                    child: VerticalDivider(color: AppColors.neutralGrey,)
                ),
                CurrentWeatherExtraInfoWidget(
                  icon: MaterialSymbols.rainy,
                  title: "${selectedForecastDay.day.dailyChanceOfRain}%",
                  description: AppLocalizations.of(context)!.rain
                ),
                SizedBox(
                  height: 80,
                  child: VerticalDivider(color: AppColors.neutralGrey,)
                ),
                CurrentWeatherExtraInfoWidget(
                    icon: MaterialSymbols.humidity_percentage_filled,
                    title: "${selectedForecastDay.day.avghumidity}%",
                    description: AppLocalizations.of(context)!.humidity
                )
              ],
            ),

            const Gap(25),

            // Lista de clima por Hora
            Expanded(
              child: ListView.separated(
                itemCount: weatherController.weather!.forecast.forecastday.length,
                separatorBuilder: (context, index) => Gap(10),
                itemBuilder: (context, index) {

                  ForecastDayEntity forecastDay = weatherController.weather!.forecast.forecastday[index];

                  return WeatherTileWidget(
                    onTap: () {

                      selectedForecastDay = forecastDay;
                      setState(() {});

                    },
                    selected: forecastDay == selectedForecastDay,
                    leading: DateFormat("EEEE, dd").format(forecastDay.date),
                    trailing: "${forecastDay.day.maxtempC.toStringAsFixed(0)}°. ${forecastDay.day.mintempC.toStringAsFixed(0)}",
                    icon: getWeatherIconWithEnumUtil(
                      iconEnum: forecastDay.day.condition.code,
                      isDark: themeController.getTheme()
                    ).fold((l) => throw Exception(l.message), (r) => r,)
                  );
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}
