import 'dart:convert';

class CreateContactRequest {
  final int idContactType;
  final String fullName;
  final String phoneNumber;
  final String? notes;
  final int idMasterContactRole;

  CreateContactRequest({
    required this.idContactType,
    required this.fullName,
    required this.phoneNumber,
    this.notes,
    required this.idMasterContactRole,
  });

  factory CreateContactRequest.fromRawJson(String str) =>
      CreateContactRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateContactRequest.fromJson(Map<String, dynamic> json) =>
      CreateContactRequest(
        idContactType: json["id_contact_type"],
        fullName: json["full_name"],
        phoneNumber: json["phone_number"],
        notes: json["notes"],
        idMasterContactRole: json["id_master_contact_role"],
      );

  Map<String, dynamic> toJson() => {
        "id_contact_type": idContactType,
        "full_name": fullName,
        "phone_number": phoneNumber,
        "notes": notes,
        "id_master_contact_role": idMasterContactRole,
      };
}
