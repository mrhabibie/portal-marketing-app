// To parse this JSON data, do
//
//     final createFollowUpRequest = createFollowUpRequestFromJson(jsonString);

import 'dart:convert';

CreateFollowUpRequest createFollowUpRequestFromJson(String str) =>
    CreateFollowUpRequest.fromJson(json.decode(str));

String createFollowUpRequestToJson(CreateFollowUpRequest data) =>
    json.encode(data.toJson());

class CreateFollowUpRequest {
  final int idMasterBrand;
  final int idContact;
  final String response;
  final int status;
  final DateTime date;

  CreateFollowUpRequest({
    required this.idMasterBrand,
    required this.idContact,
    required this.response,
    required this.status,
    required this.date,
  });

  factory CreateFollowUpRequest.fromJson(Map<String, dynamic> json) =>
      CreateFollowUpRequest(
        idMasterBrand: json["id_master_brand"],
        idContact: json["id_contact"],
        response: json["response"],
        status: json["status"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id_master_brand": idMasterBrand,
        "id_contact": idContact,
        "response": response,
        "status": status,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
      };
}
