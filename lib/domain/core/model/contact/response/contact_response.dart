// To parse this JSON data, do
//
//     final contactResponse = contactResponseFromJson(jsonString);

import 'dart:convert';

import '../../master/response/master_contact_response.dart';

ContactResponse contactResponseFromJson(String str) =>
    ContactResponse.fromJson(json.decode(str));

String contactResponseToJson(ContactResponse data) =>
    json.encode(data.toJson());

class ContactResponse {
  final List<MasterContact> contacts;
  final int totalCount;

  ContactResponse({
    required this.contacts,
    required this.totalCount,
  });

  factory ContactResponse.fromJson(Map<String, dynamic> json) =>
      ContactResponse(
        contacts: List<MasterContact>.from(
            json["contacts"].map((x) => MasterContact.fromJson(x))),
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "contacts": List<dynamic>.from(contacts.map((x) => x.toJson())),
        "totalCount": totalCount,
      };
}

class FollowUp {
  final int id;
  final DateTime date;
  final String brandName;
  final int idMarketing;
  final String marketing;
  String? alias;
  final String response;
  final int status;
  final String statusText;
  final int createdBy;
  final String createdUsername;
  String? createdAlias;
  final DateTime createdAt;
  final int flag;

  FollowUp({
    required this.id,
    required this.date,
    required this.brandName,
    required this.idMarketing,
    required this.marketing,
    this.alias,
    required this.response,
    required this.status,
    required this.statusText,
    required this.createdBy,
    required this.createdUsername,
    this.createdAlias,
    required this.createdAt,
    required this.flag,
  });

  factory FollowUp.fromJson(Map<String, dynamic> json) => FollowUp(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        brandName: json["brand_name"],
        idMarketing: json["id_marketing"],
        marketing: json["marketing"],
        alias: json["alias"],
        response: json["response"],
        status: json["status"],
        statusText: json["status_text"],
        createdBy: json["created_by"],
        createdUsername: json["created_username"],
        createdAlias: json["created_alias"],
        createdAt: DateTime.parse(json["created_at"]),
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "brand_name": brandName,
        "id_marketing": idMarketing,
        "marketing": marketing,
        "alias": alias,
        "response": response,
        "status": status,
        "status_text": statusText,
        "created_by": createdBy,
        "created_username": createdUsername,
        "created_alias": createdAlias,
        "created_at": createdAt.toIso8601String(),
        "flag": flag,
      };
}
