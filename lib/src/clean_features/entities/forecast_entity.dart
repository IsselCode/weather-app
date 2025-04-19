import 'forecast_day_entity.dart';

class ForecastEntity {
  final List<ForecastDayEntity> forecastday;

  ForecastEntity({
    required this.forecastday,
  });

  factory ForecastEntity.fromJson(Map<String, dynamic> json) => ForecastEntity(
    forecastday: List<ForecastDayEntity>.from(json["forecastday"].map((x) => ForecastDayEntity.fromJson(x))),
  );

}