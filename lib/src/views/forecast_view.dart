import 'package:flutter/material.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';
import 'package:gap/gap.dart';
import 'package:weather_app/src/clean_features/widgets/current_weather_widget.dart';

import '../../core/app/consts.dart';
import '../clean_features/widgets/current_weather_extra_info_widget.dart';
import '../clean_features/widgets/weather_tile_widget.dart';

class ForecastView extends StatelessWidget {
  const ForecastView({super.key});

  @override
  Widget build(BuildContext context) {

    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text("Próximos 7 Días", style: textTheme.titleLarge,),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [

            CurrentWeatherWidget(
              title: "Lluvia y truenos",
              temperature: "16/18",
              date: DateTime.now(),
              icon: "assets/weather_icons/PartlyCloudyDark.png"
            ),

            const Gap(25),


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
                    icon: MaterialSymbols.rainy,
                    title: "72%",
                    description: "Lluvia"
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

            const Gap(25),

            // Lista de clima por Hora
            Expanded(
              child: ListView.separated(
                itemCount: 7,
                separatorBuilder: (context, index) => Gap(10),
                itemBuilder: (context, index) {
                  return WeatherTileWidget(
                    onTap: () {

                    },
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
}
