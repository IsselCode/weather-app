import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/services/navigation_service.dart';
import 'package:weather_app/core/utils/location_util.dart';
import 'package:weather_app/src/clean_features/entities/coords_entity.dart';
import 'package:weather_app/src/clean_features/entities/weather_entity.dart';
import 'package:weather_app/src/models/shared_prefs_model.dart';
import 'package:weather_app/src/models/weather_model.dart';

import '../../core/app/failures.dart';
import '../clean_features/entities/city_entity.dart';

class WeatherController extends ChangeNotifier {

  WeatherModel weatherModel;
  LocationUtil locationUtil;
  SharedPrefsModel sharedPrefsModel;
  NavigationService navigationService;

  WeatherController({
    required this.weatherModel,
    required this.locationUtil,
    required this.sharedPrefsModel,
    required this.navigationService,
  });

  WeatherEntity? weather;

  Future<Either<AppError, CoordsEntity>> _getLocation() async {

    final (lat, lng) = await sharedPrefsModel.getLocation();

    if (lat != null && lng != null) {
      return Right(CoordsEntity(latitude: lat, longitude: lng));
    }
    else {
      Either<AppError, Position> locationResponse = await locationUtil.getCurrentPosition();
      return locationResponse.fold(
        (l) => Left(l),
        (r) {
          sharedPrefsModel.saveLocation(r.latitude, r.longitude);
          return Right(CoordsEntity(latitude: r.latitude, longitude: r.longitude));
        },
      );
    }

  }

  Future<List<CityEntity>?> searchCity(String query) async {

    Either<AppError, List<CityEntity>> response = await weatherModel.searchCity(query);

    return response.fold(
      (l) => null,
      (r) => r,
    );

  }

  void getForecast() async {

    final stopwatch = Stopwatch()..start();

    Either<AppError, CoordsEntity> locationResponse = await _getLocation();

    stopwatch.stop();

    print("getCurrentPosition() tardó: ${stopwatch.elapsedMilliseconds}");


    locationResponse.fold(
      (l) {
        print(l.message);
      },
      (position) async {

        String location = "${position.latitude},${position.longitude}";

        final stopwatch = Stopwatch()..start();

        Either<AppError, WeatherEntity> response = await weatherModel.getForecast(location);

        stopwatch.stop();

        print("getForecast() tardó: ${stopwatch.elapsedMilliseconds}");

        response.fold(
          (l) => print(l.message),
          (r) {
            weather = r;
            notifyListeners();
          },
        );

      },
    );

  }

  Future<void> getForecastWithCoords(CityEntity city) async {

    String location = "${city.lat},${city.lon}";

    Either<AppError, WeatherEntity> response = await weatherModel.getForecast(location);


    response.fold(
      (l) => print(l.message),
      (r) {
        weather = r;
        navigationService.goBack();
        notifyListeners();
      },
    );

  }

}