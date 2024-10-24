import 'dart:convert';

class MasterCityResponse {
  final List<MasterCity> cities;
  final int totalPage;
  final int totalCount;

  MasterCityResponse({
    required this.cities,
    required this.totalPage,
    required this.totalCount,
  });

  factory MasterCityResponse.fromRawJson(String str) =>
      MasterCityResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MasterCityResponse.fromJson(Map<String, dynamic> json) =>
      MasterCityResponse(
        cities: List<MasterCity>.from(
            json["cities"].map((x) => MasterCity.fromJson(x))),
        totalPage: json["totalPage"],
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "cities": List<dynamic>.from(cities.map((x) => x.toJson())),
        "totalPage": totalPage,
        "totalCount": totalCount,
      };
}

class MasterCity {
  final int id;
  final int idMasterProvince;
  final String name;
  final String cityName;
  final String? provinceName;
  final String lat;
  final String lng;
  final int flag;

  MasterCity({
    required this.id,
    required this.idMasterProvince,
    required this.name,
    required this.cityName,
    this.provinceName,
    required this.lat,
    required this.lng,
    required this.flag,
  });

  factory MasterCity.fromRawJson(String str) =>
      MasterCity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MasterCity.fromJson(Map<String, dynamic> json) => MasterCity(
        id: json["id"],
        idMasterProvince: json["id_master_province"],
        name: json["name"],
        cityName: json["city_name"],
        provinceName: json["province_name"],
        lat: json["lat"],
        lng: json["lng"],
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_master_province": idMasterProvince,
        "name": name,
        "city_name": cityName,
        "province_name": provinceName,
        "lat": lat,
        "lng": lng,
        "flag": flag,
      };
}
