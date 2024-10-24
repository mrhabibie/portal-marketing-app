import 'dart:convert';

class MasterAreaResponse {
  final int id;
  final int idMasterProvince;
  final int idMasterCity;
  final int idMasterSuburb;
  final String name;
  final String lat;
  final String lng;
  final int flag;

  MasterAreaResponse({
    required this.id,
    required this.idMasterProvince,
    required this.idMasterCity,
    required this.idMasterSuburb,
    required this.name,
    required this.lat,
    required this.lng,
    required this.flag,
  });

  factory MasterAreaResponse.fromRawJson(String str) =>
      MasterAreaResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MasterAreaResponse.fromJson(Map<String, dynamic> json) =>
      MasterAreaResponse(
        id: json["id"],
        idMasterProvince: json["id_master_province"],
        idMasterCity: json["id_master_city"],
        idMasterSuburb: json["id_master_suburb"],
        name: json["name"],
        lat: json["lat"],
        lng: json["lng"],
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_master_province": idMasterProvince,
        "id_master_city": idMasterCity,
        "id_master_suburb": idMasterSuburb,
        "name": name,
        "lat": lat,
        "lng": lng,
        "flag": flag,
      };
}
