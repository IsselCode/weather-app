enum WeatherIconEnum {

  sunny,
  partlyCloudy,
  rainy,
  snowy,
  rainThunder

}

enum LanguageTypes {

  es,
  us,
  pt;

  // Para obtener el tipo con el código
  LanguageTypes convertCode(String code) {
    switch (code) {
      case "es":
        return LanguageTypes.es;
      case "us":
        return LanguageTypes.us;
      case "pt":
        return LanguageTypes.pt;
      default:
        throw ArgumentError("Código no soportado: $code");
    }
  }

  // Para obtener el código
  String get code {
    switch (this) {
      case LanguageTypes.es:
        return "es";
      case LanguageTypes.us:
        return "us";
      case LanguageTypes.pt:
        return "pt";
    }
  }

  String get fullName {
    switch (this) {
      case LanguageTypes.es:
        return "Español";
      case LanguageTypes.us:
        return "Inglés";
      case LanguageTypes.pt:
        return "Portugués";
    }
  }

}