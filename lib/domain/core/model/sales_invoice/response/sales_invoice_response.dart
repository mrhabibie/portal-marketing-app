// To parse this JSON data, do
//
//     final salesInvoiceResponse = salesInvoiceResponseFromJson(jsonString);

import 'dart:convert';

import '../../master/response/master_contact_response.dart';
import '../../master/response/master_item_response.dart';

SalesInvoiceResponse salesInvoiceResponseFromJson(String str) =>
    SalesInvoiceResponse.fromJson(json.decode(str));

String salesInvoiceResponseToJson(SalesInvoiceResponse data) =>
    json.encode(data.toJson());

class SalesInvoiceResponse {
  final List<SalesInvoice> salesInvoices;
  final int count;
  final int totalCount;

  SalesInvoiceResponse({
    required this.salesInvoices,
    required this.count,
    required this.totalCount,
  });

  factory SalesInvoiceResponse.fromJson(Map<String, dynamic> json) =>
      SalesInvoiceResponse(
        salesInvoices: List<SalesInvoice>.from(
            json["sales_invoices"].map((x) => SalesInvoice.fromJson(x))),
        count: json["count"],
        totalCount: json["total_count"],
      );

  Map<String, dynamic> toJson() => {
        "sales_invoices":
            List<dynamic>.from(salesInvoices.map((x) => x.toJson())),
        "count": count,
        "total_count": totalCount,
      };
}

class SalesInvoice {
  final int id;
  final String invoiceNo;
  final DateTime date;
  String? receiptNumber;
  MasterContact? contact;
  final List<MasterItem> items;
  int? totalItems;
  int? grandTotal;
  final int status;
  final String statusText;
  String? note;
  int? dataBy1;
  String? dataBy1Alias;
  String? dataBy1Username;
  int? dataBy2;
  String? dataBy2Alias;
  String? dataBy2Username;
  int? closingBy1;
  String? closingBy1Alias;
  String? closingBy1Username;
  int? closingBy2;
  String? closingBy2Alias;
  String? closingBy2Username;
  final DateTime createdAt;
  DateTime? updatedAt;
  final int flag;

  SalesInvoice({
    required this.id,
    required this.invoiceNo,
    required this.date,
    this.receiptNumber,
    this.contact,
    required this.items,
    this.totalItems,
    this.grandTotal,
    required this.status,
    required this.statusText,
    this.note,
    this.dataBy1,
    this.dataBy1Alias,
    this.dataBy1Username,
    this.dataBy2,
    this.dataBy2Alias,
    this.dataBy2Username,
    this.closingBy1,
    this.closingBy1Alias,
    this.closingBy1Username,
    this.closingBy2,
    this.closingBy2Alias,
    this.closingBy2Username,
    required this.createdAt,
    this.updatedAt,
    required this.flag,
  });

  factory SalesInvoice.fromJson(Map<String, dynamic> json) => SalesInvoice(
        id: json["id"],
        invoiceNo: json["invoice_no"],
        date: DateTime.parse(json["date"]),
        receiptNumber: json["receipt_number"],
        contact: json["contact"] != null
            ? MasterContact.fromJson(json["contact"])
            : null,
        items: List<MasterItem>.from(
            json["items"].map((x) => MasterItem.fromJson(x))),
        totalItems: json["total_items"],
        grandTotal: json["grand_total"],
        status: json["status"],
        statusText: json["status_text"],
        note: json["note"],
        dataBy1: json["data_by_1"],
        dataBy1Alias: json["data_by_1_alias"],
        dataBy1Username: json["data_by_1_username"],
        dataBy2: json["data_by_2"],
        dataBy2Alias: json["data_by_2_alias"],
        dataBy2Username: json["data_by_2_username"],
        closingBy1: json["closing_by_1"],
        closingBy1Alias: json["closing_by_1_alias"],
        closingBy1Username: json["closing_by_1_username"],
        closingBy2: json["closing_by_2"],
        closingBy2Alias: json["closing_by_2_alias"],
        closingBy2Username: json["closing_by_2_username"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        flag: json["flag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "invoice_no": invoiceNo,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "receipt_number": receiptNumber,
        "contact": contact?.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "total_items": totalItems,
        "grand_total": grandTotal,
        "status": status,
        "status_text": statusText,
        "note": note,
        "data_by_1": dataBy1,
        "data_by_1_alias": dataBy1Alias,
        "data_by_1_username": dataBy1Username,
        "data_by_2": dataBy2,
        "data_by_2_alias": dataBy2Alias,
        "data_by_2_username": dataBy2Username,
        "closing_by_1": closingBy1,
        "closing_by_1_alias": closingBy1Alias,
        "closing_by_1_username": closingBy1Username,
        "closing_by_2": closingBy2,
        "closing_by_2_alias": closingBy2Alias,
        "closing_by_2_username": closingBy2Username,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "flag": flag,
      };
}
