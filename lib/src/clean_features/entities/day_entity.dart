
import 'package:weather_app/src/clean_features/entities/condition_entity.dart';

import 'package:weather_app/src/clean_features/entities/condition_entity.dart';

class DayEntity {
  final double maxtempC;
  final double mintempC;
  final double maxwindKph;
  final int avghumidity;
  final int dailyChanceOfRain;
  final ConditionEntity condition;

  DayEntity({
    required this.maxtempC,
    required this.mintempC,
    required this.maxwindKph,
    required this.avghumidity,
    required this.dailyChanceOfRain,
    required this.condition,
  });

  factory DayEntity.fromJson(Map<String, dynamic> json) => DayEntity(
    maxtempC: json["maxtemp_c"]?.toDouble(),
    mintempC: json["mintemp_c"]?.toDouble(),
    maxwindKph: json["maxwind_kph"]?.toDouble(),
    avghumidity: json["avghumidity"],
    dailyChanceOfRain: json["daily_chance_of_rain"],
    condition: ConditionEntity.fromJson(json["condition"]),
  );
}
