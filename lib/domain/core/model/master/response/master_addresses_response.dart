import 'dart:convert';

class MasterAddressesResponse {
  final List<MasterAddress> addresses;
  final int totalPage;
  final int totalCount;

  MasterAddressesResponse({
    required this.addresses,
    required this.totalPage,
    required this.totalCount,
  });

  factory MasterAddressesResponse.fromRawJson(String str) =>
      MasterAddressesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MasterAddressesResponse.fromJson(Map<String, dynamic> json) =>
      MasterAddressesResponse(
        addresses: List<MasterAddress>.from(
            json["addresses"].map((x) => MasterAddress.fromJson(x))),
        totalPage: json["totalPage"],
        totalCount: json["totalCount"],
      );

  Map<String, dynamic> toJson() => {
        "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
        "totalPage": totalPage,
        "totalCount": totalCount,
      };
}

class MasterAddress {
  final int provinceId;
  final String provinceName;
  final int cityId;
  final String cityName;
  final int suburbId;
  final String suburbName;
  final int areaId;
  final String areaName;
  final String fullAddress;

  MasterAddress({
    required this.provinceId,
    required this.provinceName,
    required this.cityId,
    required this.cityName,
    required this.suburbId,
    required this.suburbName,
    required this.areaId,
    required this.areaName,
    required this.fullAddress,
  });

  factory MasterAddress.fromRawJson(String str) => MasterAddress.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MasterAddress.fromJson(Map<String, dynamic> json) => MasterAddress(
        provinceId: json["province_id"],
        provinceName: json["province_name"],
        cityId: json["city_id"],
        cityName: json["city_name"],
        suburbId: json["suburb_id"],
        suburbName: json["suburb_name"],
        areaId: json["area_id"],
        areaName: json["area_name"],
        fullAddress: json["full_address"],
      );

  Map<String, dynamic> toJson() => {
        "province_id": provinceId,
        "province_name": provinceName,
        "city_id": cityId,
        "city_name": cityName,
        "suburb_id": suburbId,
        "suburb_name": suburbName,
        "area_id": areaId,
        "area_name": areaName,
        "full_address": fullAddress,
      };
}
