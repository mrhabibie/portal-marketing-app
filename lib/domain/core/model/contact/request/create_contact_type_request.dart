import 'dart:convert';

class CreateContactTypeRequest {
  final String name;
  final int idMasterProvince;
  final int idMasterCity;
  final int idMasterContactType;

  CreateContactTypeRequest({
    required this.name,
    required this.idMasterProvince,
    required this.idMasterCity,
    required this.idMasterContactType,
  });

  factory CreateContactTypeRequest.fromRawJson(String str) =>
      CreateContactTypeRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateContactTypeRequest.fromJson(Map<String, dynamic> json) =>
      CreateContactTypeRequest(
        name: json["name"],
        idMasterProvince: json["id_master_province"],
        idMasterCity: json["id_master_city"],
        idMasterContactType: json["id_master_contact_type"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id_master_province": idMasterProvince,
        "id_master_city": idMasterCity,
        "id_master_contact_type": idMasterContactType,
      };
}
