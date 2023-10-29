// ignore_for_file: constant_identifier_names

import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Bike {
  String image;
  String name;
  String brand;
  int price;
  Status status;
  Category category;
  double displacement;
  int maxSpeed;
  Bike({
    required this.image,
    required this.name,
    required this.brand,
    required this.price,
    this.status = Status.available,
    this.category = Category.Adventure,
    this.displacement = 1133,
    this.maxSpeed = 124,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'name': name,
      'brand': brand,
      'price': price,
      'status': status.toJson(),
      'category': category.toJson(),
    };
  }

  factory Bike.fromMap(Map<String, dynamic> map) {
    return Bike(
      image: map['image'] as String,
      name: map['name'] as String,
      brand: map['brand'] as String,
      price: map['price'] as int,
      status: Status.fromJson(map['status']),
      category: Category.fromJson(map['category']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Bike.fromJson(String source) => Bike.fromMap(
        json.decode(source) as Map<String, dynamic>,
      );
}

enum Status {
  available,
  booked,
  notAvailable;

  String toJson() => name;

  static Status fromJson(String json) => values.byName(json);
}

enum Category {
  Adventure,
  Crusier,
  Sportsbike,
  Tourer;

  String toJson() => name;

  static Category fromJson(String json) => values.byName(json);
}
