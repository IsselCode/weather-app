class CityEntity {
  CityEntity({
    required this.id,
    required this.name,
    required this.region,
    required this.country,
    required this.lat,
    required this.lon,
    required this.url,
  });

  final int id;
  final String name;
  final String region;
  final String country;
  final double lat;
  final double lon;
  final String url;

  factory CityEntity.fromJson(Map<String, dynamic> json){
    return CityEntity(
      id: json["id"] ?? 0,
      name: json["name"] ?? "",
      region: json["region"] ?? "",
      country: json["country"] ?? "",
      lat: json["lat"] ?? 0.0,
      lon: json["lon"] ?? 0.0,
      url: json["url"] ?? "",
    );
  }

}
