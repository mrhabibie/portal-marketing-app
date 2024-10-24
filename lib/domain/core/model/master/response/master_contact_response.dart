import '../../contact/response/contact_address_response.dart';
import '../../contact/response/contact_response.dart';
import '../../sales_invoice/response/sales_invoice_response.dart';

class MasterContact {
  final int id;
  final int idGroup;
  String? group;
  final String province;
  final String city;
  String? suburb;
  String? area;
  String? detailAddress;
  final String name;
  final String phoneNumber;
  final String role;
  int? status;
  String? statusText;
  final int createdBy;
  final String createdByUsername;
  String? createdByAlias;
  final DateTime createdAt;
  DateTime? updatedAt;
  final List<ContactAddressResponse>? addresses;
  final List<FollowUp>? followUps;
  final List<SalesInvoice>? salesInvoices;

  MasterContact({
    required this.id,
    required this.idGroup,
    this.group,
    required this.province,
    required this.city,
    this.suburb,
    this.area,
    this.detailAddress,
    required this.name,
    required this.phoneNumber,
    required this.role,
    this.status,
    this.statusText,
    required this.createdBy,
    required this.createdByUsername,
    this.createdByAlias,
    required this.createdAt,
    this.updatedAt,
    this.addresses,
    this.followUps,
    this.salesInvoices,
  });

  factory MasterContact.fromJson(Map<String, dynamic> json) => MasterContact(
        id: json["id"],
        idGroup: json["id_group"],
        group: json["group"],
        province: json["province"],
        city: json["city"],
        suburb: json["suburb"],
        area: json["area"],
        detailAddress: json["detail_address"],
        name: json["name"],
        phoneNumber: json["phone_number"],
        role: json["role"],
        status: json["status"],
        statusText: json["status_text"],
        createdBy: json["created_by"],
        createdByUsername: json["created_by_username"],
        createdByAlias: json["created_by_alias"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        addresses: json["addresses"] != null
            ? List<ContactAddressResponse>.from(json["addresses"]
                .map((x) => ContactAddressResponse.fromJson(x)))
            : [],
        followUps: json["follow_ups"] != null
            ? List<FollowUp>.from(
                json["follow_ups"].map((x) => FollowUp.fromJson(x)))
            : null,
        salesInvoices: json["sales_invoices"] != null
            ? List<SalesInvoice>.from(
                json["sales_invoices"].map((x) => SalesInvoice.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_group": idGroup,
        "group": group,
        "province": province,
        "city": city,
        "suburb": suburb,
        "area": area,
        "detail_address": detailAddress,
        "name": name,
        "phone_number": phoneNumber,
        "role": role,
        "status": status,
        "status_text": statusText,
        "created_by": createdBy,
        "created_by_username": createdByUsername,
        "created_by_alias": createdByAlias,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "addresses": addresses != null
            ? List<dynamic>.from(addresses!.map((x) => x.toJson()))
            : [],
        "follow_ups": followUps != null
            ? List<dynamic>.from(followUps!.map((x) => x.toJson()))
            : [],
        "sales_invoices": salesInvoices != null
            ? List<dynamic>.from(salesInvoices!.map((x) => x.toJson()))
            : [],
      };
}
