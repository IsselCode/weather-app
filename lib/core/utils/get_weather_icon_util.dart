
import 'package:dartz/dartz.dart';

import '../app/consts.dart';
import '../app/enums.dart';
import '../app/failures.dart';

Either<AppError, WeatherIconEnum> getWeatherEnumIconWithCodeUtil(code) {

  if (code == 1000) return Right(WeatherIconEnum.sunny);

  if ([1003, 1006, 1009, 1030, 1135, 1147].contains(code)) return Right(WeatherIconEnum.partlyCloudy);

  if ((code >= 1063 && code <= 1201) || (code >= 1240 && code <= 1246) || (code >= 1261 && code <= 1264)) {
    return Right(WeatherIconEnum.rainy);
  }

  if ((code >= 1066 && code <= 1225) || (code >= 1255 && code <= 1258)) {
    return Right(WeatherIconEnum.snowy);
  }

  if ([1087, 1273, 1276, 1279, 1282].contains(code)) {
    return Right(WeatherIconEnum.rainThunder);
  }

  return Left(UtilError(message: "Icono no identificado"));

}

Either<AppError, String> getWeatherIconWithEnumUtil({required WeatherIconEnum iconEnum, required bool isDark}) {

  try {

    switch (iconEnum) {

      case WeatherIconEnum.sunny:
        return Right(WeatherIcons.sunny);
      case WeatherIconEnum.partlyCloudy:
        return Right(isDark ? WeatherIcons.partlyCloudyLight : WeatherIcons.partlyCloudyDark);
      case WeatherIconEnum.rainy:
        return Right(isDark ? WeatherIcons.rainyLight : WeatherIcons.rainyDark);
      case WeatherIconEnum.snowy:
        return Right(isDark ? WeatherIcons.snowyLight : WeatherIcons.snowyDark);
      case WeatherIconEnum.rainThunder:
        return Right(isDark ? WeatherIcons.rainThunderLight : WeatherIcons.rainThunderDark);
    }

  } catch (e) {
    return Left(UtilError(message: "Error desconocido"));
  }

}