import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class CurrentWeatherWidget extends StatelessWidget {

  final String title;
  final String temperature;
  final DateTime date;
  final String icon;

  const CurrentWeatherWidget({
    super.key,
    required this.title,
    required this.temperature,
    required this.date,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {

    TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
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
                      SizedBox(
                        width: 200,
                        child: Text(title, style: textTheme.titleMedium, maxLines: 2,)
                      ),
                      const Gap(5),
                      Text(DateFormat("EEE dd, MMM yy - hh:mm a").format(date), style: textTheme.labelMedium,),
                    ],
                  ),
                  // Temperatura
                  Text("$temperature°", style: textTheme.displayLarge,)
                ],
              ),

              //* Icono
              Image.asset(
                icon,
                width: 128,
                height: 128,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
