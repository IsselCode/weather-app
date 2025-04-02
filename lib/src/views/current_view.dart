import 'package:flutter/material.dart';
import 'package:flutter_material_symbols/flutter_material_symbols.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/core/app/consts.dart';
import 'package:weather_app/src/clean_features/widgets/current_weather_extra_info_widget.dart';
import 'package:weather_app/src/clean_features/widgets/weather_tile_widget.dart';

class CurrentView extends StatelessWidget {
  const CurrentView({super.key});

  @override
  Widget build(BuildContext context) {

    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(Icons.location_on_outlined, size: 24,),
            const Gap(5),
            Text("Monterrey, México", style: textTheme.titleMedium,)
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

            // Clima Actual
            SizedBox(
              height: 200,
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      //* Titulos
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Texto y fecha
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("lluvia y truenos", style: textTheme.titleMedium,),
                              Text(DateFormat("EEE dd, MMM yy - hh:mm a").format(DateTime.now()), style: textTheme.labelMedium,),
                            ],
                          ),
                          // Temperatura
                          Text("16°", style: textTheme.displayLarge,)
                        ],
                      ),

                      //* Icono
                      Image.asset(
                        "assets/weather_icons/SnowyDark.png",
                        width: 128,
                        height: 128,
                      ),

                    ],
                  ),
                ),
              ),
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
  }

  void setLanguage(BuildContext context) {



  }

  void setLocation(BuildContext context) {

  }

}
