// To parse this JSON data, do
//
//     final priceResponse = priceResponseFromJson(jsonString);

import 'dart:convert';

PriceResponse priceResponseFromJson(String str) =>
    PriceResponse.fromJson(json.decode(str));

String priceResponseToJson(PriceResponse data) => json.encode(data.toJson());

class PriceResponse {
  final int loko;
  final int usDtoIdr;
  final int goldPriceIdr;
  final List<PGC100> pgc100;
  final List<PGCEcer> pgc15;
  final List<PGCEcer> pgc1;

  PriceResponse({
    required this.loko,
    required this.usDtoIdr,
    required this.goldPriceIdr,
    required this.pgc100,
    required this.pgc15,
    required this.pgc1,
  });

  factory PriceResponse.fromJson(Map<String, dynamic> json) => PriceResponse(
        loko: json["loko"],
        usDtoIdr: json["USDtoIDR"],
        goldPriceIdr: json["GoldPriceIDR"],
        pgc100:
            List<PGC100>.from(json["pgc100"].map((x) => PGC100.fromJson(x))),
        pgc15:
            List<PGCEcer>.from(json["pgc15"].map((x) => PGCEcer.fromJson(x))),
        pgc1: List<PGCEcer>.from(json["pgc1"].map((x) => PGCEcer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "loko": loko,
        "USDtoIDR": usDtoIdr,
        "GoldPriceIDR": goldPriceIdr,
        "pgc100": List<dynamic>.from(pgc100.map((x) => x.toJson())),
        "pgc15": List<dynamic>.from(pgc15.map((x) => x.toJson())),
        "pgc1": List<dynamic>.from(pgc1.map((x) => x.toJson())),
      };
}

class PGCEcer {
  final String name;
  final String perkalian;
  final int harga;

  PGCEcer({
    required this.name,
    required this.perkalian,
    required this.harga,
  });

  factory PGCEcer.fromJson(Map<String, dynamic> json) => PGCEcer(
        name: json["name"],
        perkalian: json["perkalian"],
        harga: json["harga"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "perkalian": perkalian,
        "harga": harga,
      };
}

class PGC100 {
  final bool isThreshold;
  final String perkalian;
  final int harga;

  PGC100({
    required this.isThreshold,
    required this.perkalian,
    required this.harga,
  });

  factory PGC100.fromJson(Map<String, dynamic> json) => PGC100(
        isThreshold: json["is_threshold"],
        perkalian: json["perkalian"],
        harga: json["harga"],
      );

  Map<String, dynamic> toJson() => {
        "is_threshold": isThreshold,
        "perkalian": perkalian,
        "harga": harga,
      };
}
