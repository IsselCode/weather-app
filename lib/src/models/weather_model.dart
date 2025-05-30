import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:weather_app/core/app/failures.dart';
import 'package:weather_app/src/clean_features/entities/city_entity.dart';
import 'package:weather_app/src/clean_features/entities/weather_entity.dart';
import 'package:http/http.dart' as http;

const _BASEURL = "http://api.weatherapi.com/v1";
const _APIKEY = "29a6acc0022846579de164723250203";

class WeatherModel {

  Future<Either<AppError, WeatherEntity>> getForecast(String location) async {

    final uri = Uri.parse("${_BASEURL}/forecast.json").replace(
      queryParameters: {
        "key": _APIKEY,
        "q": location,
        "days": "3",
        "lang": "es"
      }
    );

    try {

      final response = await http.get(uri);

      // Verificar si la solicitud fue exitosa con un código 200
      if (response.statusCode == 200) {
        // Decodificar la respuesta JSON
        final data = json.decode(response.body);
        // Crear Entidad de Clima
        WeatherEntity weather = WeatherEntity.fromJson(data);
        // Devolver un Right con la información
        return Right(weather);
      } else {
        return Left(ServerError(message: "Algo falló al obtener el pronosticó"));
      }

    } catch (e) {
      return Left(ServerError(message: e.toString()));
    }

  }

  Future<Either<AppError, List<CityEntity>>> searchCity(String location) async {

    final uri = Uri.parse("${_BASEURL}/search.json").replace(
        queryParameters: {
          "key": _APIKEY,
          "q": location,
        }
    );

    try {

      final response = await http.get(uri);

      // Verificar si la solicitud fue exitosa con un código 200
      if (response.statusCode == 200) {
        // Lista temporal para ciudades
        List<CityEntity> tempCities = <CityEntity>[];

        // Decodificar la respuesta JSON
        final cities = json.decode(response.body);

        // Iterar cada ciudad para crear entidades
        for (var cityData in cities) {
          // Crear Entidad de Ciudad
          CityEntity city = CityEntity.fromJson(cityData);
          tempCities.add(city);
        }

        // Devolver un Right con la información
        return Right(tempCities);
      } else {
        return Left(ServerError(message: "Algo falló al buscar la ciudad"));
      }

    } catch (e) {
      return Left(ServerError(message: e.toString()));
    }

  }

}