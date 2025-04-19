import 'package:dartz/dartz.dart';
import 'package:weather_app/core/app/enums.dart';
import 'package:weather_app/core/app/failures.dart';
import 'package:weather_app/core/utils/get_weather_icon_util.dart';

class ConditionEntity {
  final String text;
  final WeatherIconEnum code;

  ConditionEntity({
    required this.text,
    required this.code,
  });

  factory ConditionEntity.fromJson(Map<String, dynamic> json) {

    Either<AppError, WeatherIconEnum> response = getWeatherEnumIconWithCodeUtil(json["code"]);

    return ConditionEntity(
      text: json["text"],
      code: response.fold(
        (l) => throw UnimplementedError(l.message),
        (r) => r,
      ),
    );
  }

}