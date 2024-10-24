import 'dart:convert';

class ContactTypeResponse {
  final List<ContactType> types;
  final int totalCount;

  ContactTypeResponse({
    required this.types,
    required this.totalCount,
  });

  factory ContactTypeResponse.fromRawJson(String str) =>
      ContactTypeResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContactTypeResponse.fromJson(Map<String, dynamic> json) =>
      ContactTypeResponse(
        types: List<ContactType>.from(
            json["types"].map((x) => ContactType.fromJson(x))),
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "types": List<dynamic>.from(types.map((x) => x.toJson())),
        "totalCount": totalCount,
      };
}

class ContactType {
  final int id;
  final String name;
  final String province;
  final String city;

  ContactType({
    required this.id,
    required this.name,
    required this.province,
    required this.city,
  });

  factory ContactType.fromRawJson(String str) =>
      ContactType.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContactType.fromJson(Map<String, dynamic> json) => ContactType(
        id: json["id"],
        name: json["name"],
        province: json["province"],
        city: json["city"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "province": province,
        "city": city,
      };
}
