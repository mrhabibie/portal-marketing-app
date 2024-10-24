import 'dart:convert';

class PriceList {
  final List<Datum> data;

  PriceList({
    required this.data,
  });

  factory PriceList.fromRawJson(String str) =>
      PriceList.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PriceList.fromJson(Map<String, dynamic> json) => PriceList(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  final String name;
  final int price;
  final bool isThreshold;

  Datum({
    required this.name,
    required this.price,
    this.isThreshold = false,
  });

  factory Datum.fromRawJson(String str) => Datum.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        name: json["name"],
        price: json["price"],
        isThreshold: json["is_threshold"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "is_threshold": isThreshold,
      };
}
