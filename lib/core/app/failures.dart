class AppError {

  String message;

  AppError({
    required this.message
  });

}

class UtilError extends AppError {
  UtilError({required super.message});
}

class ServerError extends AppError {
  ServerError({required super.message});
}