import 'dart:convert';

class CreateContactAddressRequest {
  final int idContactType;
  final String fullName;
  final String phoneNumber;
  final String address;
  final int idMasterProvince;
  final int idMasterCity;
  final int idMasterSuburb;
  final int idMasterArea;

  CreateContactAddressRequest({
    required this.idContactType,
    required this.fullName,
    required this.phoneNumber,
    required this.address,
    required this.idMasterProvince,
    required this.idMasterCity,
    required this.idMasterSuburb,
    required this.idMasterArea,
  });

  factory CreateContactAddressRequest.fromRawJson(String str) =>
      CreateContactAddressRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateContactAddressRequest.fromJson(Map<String, dynamic> json) =>
      CreateContactAddressRequest(
        idContactType: json["id_contact_type"],
        fullName: json["full_name"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        idMasterProvince: json["id_master_province"],
        idMasterCity: json["id_master_city"],
        idMasterSuburb: json["id_master_suburb"],
        idMasterArea: json["id_master_area"],
      );

  Map<String, dynamic> toJson() => {
        "id_contact_type": idContactType,
        "full_name": fullName,
        "phone_number": phoneNumber,
        "address": address,
        "id_master_province": idMasterProvince,
        "id_master_city": idMasterCity,
        "id_master_suburb": idMasterSuburb,
        "id_master_area": idMasterArea,
      };
}
