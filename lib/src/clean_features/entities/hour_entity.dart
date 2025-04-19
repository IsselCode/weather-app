import 'package:weather_app/src/clean_features/entities/condition_entity.dart';

import 'package:weather_app/src/clean_features/entities/condition_entity.dart';

class HourEntity {
  final int timeEpoch;
  final String time;
  final double tempC;
  final ConditionEntity condition;
  final int humidity;
  final double gustKph;

  HourEntity({
    required this.timeEpoch,
    required this.time,
    required this.tempC,
    required this.condition,
    required this.humidity,
    required this.gustKph,
  });

  factory HourEntity.fromJson(Map<String, dynamic> json) => HourEntity(
    timeEpoch: json["time_epoch"],
    time: json["time"],
    tempC: json["temp_c"]?.toDouble(),
    condition: ConditionEntity.fromJson(json["condition"]),
    humidity: json["humidity"],
    gustKph: json["gust_kph"]?.toDouble(),
  );

}