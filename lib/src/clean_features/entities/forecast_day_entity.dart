
import 'package:weather_app/src/clean_features/entities/day_entity.dart';

import 'package:weather_app/src/clean_features/entities/hour_entity.dart';

class ForecastDayEntity {
  final DateTime date;
  final int dateEpoch;
  final DayEntity day;
  final List<HourEntity> hour;

  ForecastDayEntity({
    required this.date,
    required this.dateEpoch,
    required this.day,
    required this.hour,
  });

  factory ForecastDayEntity.fromJson(Map<String, dynamic> json) => ForecastDayEntity(
    date: DateTime.parse(json["date"]),
    dateEpoch: json["date_epoch"],
    day: DayEntity.fromJson(json["day"]),
    hour: List<HourEntity>.from(json["hour"].map((x) => HourEntity.fromJson(x))),
  );

}
