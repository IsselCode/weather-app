import 'package:weather_app/src/clean_features/entities/forecast_entity.dart';
import 'package:weather_app/src/clean_features/entities/location_entity.dart';
import 'current_entity.dart';

class WeatherEntity {
  final LocationEntity location;
  final CurrentEntity current;
  final ForecastEntity forecast;

  WeatherEntity({
    required this.location,
    required this.current,
    required this.forecast,
  });

  factory WeatherEntity.fromJson(Map<String, dynamic> json) => WeatherEntity(
    location: LocationEntity.fromJson(json["location"]),
    current: CurrentEntity.fromJson(json["current"]),
    forecast: ForecastEntity.fromJson(json["forecast"]),
  );
}