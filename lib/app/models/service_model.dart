import 'dart:convert';

List<ServiceModel> serviceModelFromJson(String str) => List<ServiceModel>.from(
    json.decode(str).map((x) => ServiceModel.fromJson(x)));

String serviceModelToJson(List<ServiceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ServiceModel {
  int? id;
  String? category;
  String? name;
  String? price;
  String? min;
  String? max;
  String? note;

  ServiceModel({
    this.id,
    this.category,
    this.name,
    this.price,
    this.min,
    this.max,
    this.note,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
        id: json["id"],
        category: json["category"],
        name: json["name"],
        price: json["price"],
        min: json["min"],
        max: json["max"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category": category,
        "name": name,
        "price": price,
        "min": min,
        "max": max,
        "note": note,
      };
}
