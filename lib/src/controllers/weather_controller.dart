import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/src/clean_features/entities/weather_entity.dart';
import 'package:weather_app/src/models/weather_model.dart';

import '../../core/app/failures.dart';

class WeatherController extends ChangeNotifier {

  WeatherModel weatherModel;

  WeatherController({
    required this.weatherModel,
  });

  WeatherEntity? weather;

  void getForecast() async {

    String location = "New York";

    Either<AppError, WeatherEntity> response = await weatherModel.getForecast(location);

    response.fold(
      (l) => print(l.message),
      (r) {
        weather = r;
        notifyListeners();
      },
    );

  }

}