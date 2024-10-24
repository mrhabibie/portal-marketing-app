import 'dart:convert';

class ContactAddressResponse {
  final int id;
  final String address;
  final String name;
  final String phone;

  ContactAddressResponse({
    required this.id,
    required this.address,
    required this.name,
    required this.phone,
  });

  factory ContactAddressResponse.fromRawJson(String str) =>
      ContactAddressResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ContactAddressResponse.fromJson(Map<String, dynamic> json) =>
      ContactAddressResponse(
        id: json["id"],
        address: json["address"],
        name: json["name"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "address": address,
        "name": name,
        "phone": phone,
      };
}
