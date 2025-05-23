import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/app/failures.dart';

class LocationUtil {

  Future<Either<AppError, Position>> getCurrentPosition() async {

    // Verificar si el servicio de ubicación está habilitado
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Servicio de ubicación no está habilitado
      return Left(UtilError(message: "Servicio de ubicación no está habilitado"));
    }

    // Verificar estado del permiso
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Solicitar permiso al usuario
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permiso denegado
        return Left(UtilError(message: "Permiso denegado"));
      }
    }

    // Comprobación de permiso denegado permanentemente
    if (permission == LocationPermission.deniedForever) {
      return Left(UtilError(message: "Permiso denegado permanentemente"));
    }

    Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 100,
      )
    );

    print(position);

    return Right(position);

  }

}