import 'package:flutter/material.dart';

import '../../../core/app/consts.dart';

class WeatherTileWidget extends StatelessWidget {

  final String leading;
  final String trailing;
  final String icon;
  final VoidCallback onTap;
  final bool selected;

  const WeatherTileWidget({
    super.key,
    required this.leading,
    required this.trailing,
    required this.icon,
    required this.onTap,
    this.selected = false
  });

  @override
  Widget build(BuildContext context) {

    TextTheme textTheme = Theme.of(context).textTheme;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: EdgeInsets.all(1),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: selected ? colorScheme.primary : colorScheme.surface,
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
      ),
    );
  }
}
