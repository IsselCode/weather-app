enum WeatherIconEnum {

  sunny,
  partlyCloudy,
  rainy,
  snowy,
  rainThunder

}

enum LanguageTypes {

  es,
  en,
  pt;

  // Para obtener el tipo con el código
  static LanguageTypes convertCode(String code) {
    switch (code) {
      case "es":
        return LanguageTypes.es;
      case "en":
        return LanguageTypes.en;
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
      case LanguageTypes.en:
        return "en";
      case LanguageTypes.pt:
        return "pt";
    }
  }

  String get fullName {
    switch (this) {
      case LanguageTypes.es:
        return "Español";
      case LanguageTypes.en:
        return "Inglés";
      case LanguageTypes.pt:
        return "Portugués";
    }
  }

}