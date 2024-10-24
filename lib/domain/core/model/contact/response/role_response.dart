import 'dart:convert';

class RoleResponse {
  final int id;
  final String name;
  final int flag;

  RoleResponse({
    required this.id,
    required this.name,
    required this.flag,
  });

  factory RoleResponse.fromRawJson(String str) =>
      RoleResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RoleResponse.fromJson(Map<String, dynamic> json) => RoleResponse(
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
