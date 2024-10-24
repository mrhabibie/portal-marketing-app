// To parse this JSON data, do
//
//     final followUpResponse = followUpResponseFromJson(jsonString);

import 'dart:convert';

FollowUpResponse followUpResponseFromJson(String str) =>
    FollowUpResponse.fromJson(json.decode(str));

String followUpResponseToJson(FollowUpResponse data) =>
    json.encode(data.toJson());

class FollowUpResponse {
  final List<ListFollowUp> followUps;
  final int totalCount;

  FollowUpResponse({
    required this.followUps,
    required this.totalCount,
  });

  factory FollowUpResponse.fromJson(Map<String, dynamic> json) =>
      FollowUpResponse(
        followUps: List<ListFollowUp>.from(
            json["follow_ups"].map((x) => ListFollowUp.fromJson(x))),
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "follow_ups": List<dynamic>.from(followUps.map((x) => x.toJson())),
        "totalCount": totalCount,
      };
}

class ListFollowUp {
  final DateTime date;
  final List<Datum> data;

  ListFollowUp({
    required this.date,
    required this.data,
  });

  factory ListFollowUp.fromJson(Map<String, dynamic> json) => ListFollowUp(
        date: DateTime.parse(json["date"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final int id;
  final int idMarketing;
  String? alias;
  final String marketing;
  final DateTime createdAt;
  final int customersCount;
  final List<Customer> customers;

  Datum({
    required this.id,
    required this.idMarketing,
    this.alias,
    required this.marketing,
    required this.createdAt,
    required this.customersCount,
    required this.customers,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        idMarketing: json["id_marketing"],
        alias: json["alias"],
        marketing: json["marketing"],
        createdAt: DateTime.parse(json["created_at"]),
        customersCount: json["customers_count"],
        customers: List<Customer>.from(
            json["customers"].map((x) => Customer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_marketing": idMarketing,
        "alias": alias,
        "marketing": marketing,
        "created_at": createdAt.toIso8601String(),
        "customers_count": customersCount,
        "customers": List<dynamic>.from(customers.map((x) => x.toJson())),
      };
}

class Customer {
  final int id;
  final int idContact;
  final String contact;
  final int idGroup;
  final String group;
  final int idBrand;
  final String brand;
  final String response;
  final int status;
  final String statusText;

  Customer({
    required this.id,
    required this.idContact,
    required this.contact,
    required this.idGroup,
    required this.group,
    required this.idBrand,
    required this.brand,
    required this.response,
    required this.status,
    required this.statusText,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        idContact: json["id_contact"],
        contact: json["contact"],
        idGroup: json["id_group"],
        group: json["group"],
        idBrand: json["id_brand"],
        brand: json["brand"],
        response: json["response"],
        status: json["status"],
        statusText: json["status_text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_contact": idContact,
        "contact": contact,
        "id_group": idGroup,
        "group": group,
        "id_brand": idBrand,
        "brand": brand,
        "response": response,
        "status": status,
        "status_text": statusText,
      };
}
