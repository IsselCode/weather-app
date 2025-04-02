import 'package:flutter/material.dart';

import '../../../core/app/consts.dart';

class WeatherTileWidget extends StatelessWidget {

  final String leading;
  final String trailing;
  final String icon;

  const WeatherTileWidget({
    super.key,
    required this.leading,
    required this.trailing,
    required this.icon
  });

  @override
  Widget build(BuildContext context) {

    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                offset: Offset(0, 4),
                blurRadius: 4
            )
          ]
      ),
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //* Hora
          Text(
            leading,
            style: textTheme.titleMedium
          ),
          //* Icono
          Image.asset(
            icon,
            width: 36,
            height: 36,
          ),
          //* Temperatura
          Text("$trailing°", style: textTheme.titleMedium,)
        ],
      ),
    );
  }
}
