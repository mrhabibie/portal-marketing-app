import 'dart:convert';

class MasterContactTypeResponse {
  final int id;
  final String name;
  final int flag;

  MasterContactTypeResponse({
    required this.id,
    required this.name,
    required this.flag,
  });

  factory MasterContactTypeResponse.fromRawJson(String str) =>
      MasterContactTypeResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MasterContactTypeResponse.fromJson(Map<String, dynamic> json) =>
      MasterContactTypeResponse(
        id: json["id"],
        name: json["name"],
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "flag": flag,
      };
}
