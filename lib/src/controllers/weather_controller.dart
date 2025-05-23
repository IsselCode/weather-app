import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/utils/location_util.dart';
import 'package:weather_app/src/clean_features/entities/weather_entity.dart';
import 'package:weather_app/src/models/weather_model.dart';

import '../../core/app/failures.dart';

class WeatherController extends ChangeNotifier {

  WeatherModel weatherModel;
  LocationUtil locationUtil;

  WeatherController({
    required this.weatherModel,
    required this.locationUtil,
  });

  WeatherEntity? weather;

  void getForecast() async {

    Either<AppError, Position> locationResponse = await locationUtil.getCurrentPosition();

    locationResponse.fold(
      (l) {
        print(l.message);
      },
      (position) async {

        String location = "${position.latitude},${position.longitude}";

        Either<AppError, WeatherEntity> response = await weatherModel.getForecast(location);

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

}