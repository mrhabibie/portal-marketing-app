class MasterItem {
  final int id;
  final int idMasterItem;
  final String itemName;
  final String itemBrand;
  final String itemGrade;
  final String itemVolume;
  final String itemType;
  final int qty;
  int? price;
  int? discount;
  int? loco;
  int? goldPrice;
  String? notes;
  final DateTime createdAt;
  DateTime? updatedAt;

  MasterItem({
    required this.id,
    required this.idMasterItem,
    required this.itemName,
    required this.itemBrand,
    required this.itemGrade,
    required this.itemVolume,
    required this.itemType,
    required this.qty,
    this.price,
    this.discount,
    this.loco,
    this.goldPrice,
    this.notes,
    required this.createdAt,
    this.updatedAt,
  });

  factory MasterItem.fromJson(Map<String, dynamic> json) => MasterItem(
    id: json["id"],
    idMasterItem: json["id_master_item"],
    itemName: json["item_name"],
    itemBrand: json["item_brand"],
    itemGrade: json["item_grade"],
    itemVolume: json["item_volume"],
    itemType: json["item_type"],
    qty: json["qty"],
    price: json["price"] ?? 0,
    discount: json["discount"] ?? 0,
    loco: json["loco"] ?? 0,
    goldPrice: json["gold_price"] ?? 0,
    notes: json["notes"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] != null
        ? DateTime.parse(json["updated_at"])
        : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_master_item": idMasterItem,
    "item_name": itemName,
    "item_brand": itemBrand,
    "item_grade": itemGrade,
    "item_volume": itemVolume,
    "item_type": itemType,
    "qty": qty,
    "price": price ?? 0,
    "discount": discount ?? 0,
    "loco": loco ?? 0,
    "gold_price": goldPrice ?? 0,
    "notes": notes,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}