import 'package:flutter/material.dart';

class CurrentWeatherExtraInfoWidget extends StatelessWidget {

  final IconData icon;
  final String title;
  final String description;

  const CurrentWeatherExtraInfoWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.description
  });

  @override
  Widget build(BuildContext context) {

    TextTheme textTheme = Theme.of(context).textTheme;

    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 48,),
          Text(title, style: textTheme.bodyMedium,),
          Text(description, style: textTheme.labelMedium,)
        ],
      ),
    );
  }
}
