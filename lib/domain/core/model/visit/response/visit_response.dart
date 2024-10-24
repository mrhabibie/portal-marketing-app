// To parse this JSON data, do
//
//     final visitResponse = visitResponseFromJson(jsonString);

import 'dart:convert';

VisitResponse visitResponseFromJson(String str) =>
    VisitResponse.fromJson(json.decode(str));

String visitResponseToJson(VisitResponse data) => json.encode(data.toJson());

class VisitResponse {
  final int todayVisit;
  final List<HistoryVisit> historyVisit;

  VisitResponse({
    required this.todayVisit,
    required this.historyVisit,
  });

  factory VisitResponse.fromJson(Map<String, dynamic> json) => VisitResponse(
        todayVisit: json["today_visit"],
        historyVisit: List<HistoryVisit>.from(
            json["history_visit"].map((x) => HistoryVisit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "today_visit": todayVisit,
        "history_visit":
            List<dynamic>.from(historyVisit.map((x) => x.toJson())),
      };
}

class HistoryVisit {
  final int id;
  final int idContactType;
  final String contactType;
  final int idSales1;
  final String sales1;
  final String aliasSales1;
  final int? idSales2;
  final String? sales2;
  final String? aliasSales2;
  final DateTime visitAt;
  final String proof;
  final String? note;
  final DateTime createdAt;
  final int createdBy;
  final String? usernameCreatedBy;
  final String? aliasCreatedBy;
  final DateTime? updatedAt;
  final int? updatedBy;
  final String? usernameUpdatedBy;
  final String? aliasUpdatedBy;
  final int flag;

  HistoryVisit({
    required this.id,
    required this.idContactType,
    required this.contactType,
    required this.idSales1,
    required this.sales1,
    required this.aliasSales1,
    this.idSales2,
    this.sales2,
    this.aliasSales2,
    required this.visitAt,
    required this.proof,
    this.note,
    required this.createdAt,
    required this.createdBy,
    required this.usernameCreatedBy,
    required this.aliasCreatedBy,
    this.updatedAt,
    this.updatedBy,
    this.usernameUpdatedBy,
    this.aliasUpdatedBy,
    required this.flag,
  });

  factory HistoryVisit.fromJson(Map<String, dynamic> json) => HistoryVisit(
        id: json["id"],
        idContactType: json["id_contact_type"],
        contactType: json["contact_type"],
        idSales1: json["id_sales_1"],
        sales1: json["sales_1"],
        aliasSales1: json["alias_sales_1"],
        idSales2: json["id_sales_2"],
        sales2: json["sales_2"],
        aliasSales2: json["alias_sales_2"],
        visitAt: DateTime.parse(json["visit_at"]),
        proof: json["proof"],
        note: json["note"],
        createdAt: DateTime.parse(json["created_at"]),
        createdBy: json["created_by"],
        usernameCreatedBy: json["username_created_by"],
        aliasCreatedBy: json["alias_created_by"],
        updatedAt: DateTime.parse(json["updated_at"]),
        updatedBy: json["updated_by"],
        usernameUpdatedBy: json["username_updated_by"],
        aliasUpdatedBy: json["alias_updated_by"],
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_contact_type": idContactType,
        "contact_type": contactType,
        "id_sales_1": idSales1,
        "sales_1": sales1,
        "alias_sales_1": aliasSales1,
        "id_sales_2": idSales2,
        "sales_2": sales2,
        "alias_sales_2": aliasSales2,
        "visit_at": visitAt.toIso8601String(),
        "proof": proof,
        "note": note,
        "created_at": createdAt.toIso8601String(),
        "created_by": createdBy,
        "username_created_by": usernameCreatedBy,
        "alias_created_by": aliasCreatedBy,
        "updated_at": updatedAt?.toIso8601String(),
        "updated_by": updatedBy,
        "username_updated_by": usernameUpdatedBy,
        "alias_updated_by": aliasUpdatedBy,
        "flag": flag,
      };
}
