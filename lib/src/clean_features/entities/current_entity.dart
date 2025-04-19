import 'package:weather_app/src/clean_features/entities/condition_entity.dart';

import 'package:weather_app/src/clean_features/entities/condition_entity.dart';

class CurrentEntity {
  final int lastUpdatedEpoch;
  final String lastUpdated;
  final double tempC;
  final int isDay;
  final ConditionEntity condition;
  final int humidity;
  final double feelslikeC;
  final double gustKph;

  CurrentEntity({
    required this.lastUpdatedEpoch,
    required this.lastUpdated,
    required this.tempC,
    required this.isDay,
    required this.condition,
    required this.humidity,
    required this.feelslikeC,
    required this.gustKph,
  });

  factory CurrentEntity.fromJson(Map<String, dynamic> json) => CurrentEntity(
    lastUpdatedEpoch: json["last_updated_epoch"],
    lastUpdated: json["last_updated"],
    tempC: json["temp_c"]?.toDouble(),
    isDay: json["is_day"],
    condition: ConditionEntity.fromJson(json["condition"]),
    humidity: json["humidity"],
    feelslikeC: json["feelslike_c"]?.toDouble(),
    gustKph: json["gust_kph"]?.toDouble(),
  );

}