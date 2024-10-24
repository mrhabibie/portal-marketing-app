import 'dart:convert';
import 'dart:io';

class CreateVisitRequest {
  final int idContactType;
  final int idSales1;
  final int? idSales2;
  final DateTime visitAt;
  final File? proof;
  final String? note;

  CreateVisitRequest({
    required this.idContactType,
    required this.idSales1,
    this.idSales2,
    required this.visitAt,
    this.proof,
    this.note,
  });

  factory CreateVisitRequest.fromRawJson(String str) =>
      CreateVisitRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreateVisitRequest.fromJson(Map<String, dynamic> json) =>
      CreateVisitRequest(
        idContactType: json["id_contact_type"],
        idSales1: json["id_sales_1"],
        idSales2: json["id_sales_2"],
        visitAt: json["visit_at"],
        proof: json["proof"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "id_contact_type": idContactType,
        "id_sales_1": idSales1,
        "id_sales_2": idSales2,
        "visit_at": visitAt,
        "proof": proof,
        "note": note,
      };
}
