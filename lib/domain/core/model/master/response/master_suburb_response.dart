import 'dart:convert';

class MasterSuburbResponse {
  final int id;
  final int idMasterProvince;
  final int idMasterCity;
  final String name;
  final String lat;
  final String lng;
  final int flag;

  MasterSuburbResponse({
    required this.id,
    required this.idMasterProvince,
    required this.idMasterCity,
    required this.name,
    required this.lat,
    required this.lng,
    required this.flag,
  });

  factory MasterSuburbResponse.fromRawJson(String str) =>
      MasterSuburbResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MasterSuburbResponse.fromJson(Map<String, dynamic> json) =>
      MasterSuburbResponse(
        id: json["id"],
        idMasterProvince: json["id_master_province"],
        idMasterCity: json["id_master_city"],
        name: json["name"],
        lat: json["lat"],
        lng: json["lng"],
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_master_province": idMasterProvince,
        "id_master_city": idMasterCity,
        "name": name,
        "lat": lat,
        "lng": lng,
        "flag": flag,
      };
}
