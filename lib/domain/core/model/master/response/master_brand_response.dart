// To parse this JSON data, do
//
//     final masterBrand = masterBrandFromJson(jsonString);

import 'dart:convert';

MasterBrand masterBrandFromJson(String str) =>
    MasterBrand.fromJson(json.decode(str));

String masterBrandToJson(MasterBrand data) => json.encode(data.toJson());

class MasterBrand {
  final int id;
  final String name;
  final int flag;

  MasterBrand({
    required this.id,
    required this.name,
    required this.flag,
  });

  factory MasterBrand.fromJson(Map<String, dynamic> json) => MasterBrand(
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
