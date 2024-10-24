import 'dart:convert';

class MasterProvinceResponse {
  final int id;
  final String name;
  final String lat;
  final String lng;
  final int flag;

  MasterProvinceResponse({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    required this.flag,
  });

  factory MasterProvinceResponse.fromRawJson(String str) =>
      MasterProvinceResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MasterProvinceResponse.fromJson(Map<String, dynamic> json) =>
      MasterProvinceResponse(
        id: json["id"],
        name: json["name"],
        lat: json["lat"],
        lng: json["lng"],
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "lat": lat,
        "lng": lng,
        "flag": flag,
      };
}
