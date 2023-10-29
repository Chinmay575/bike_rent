import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Equipment {
  String name;
  String image;
  int price;
  int q;
  Equipment({
    required this.name,
    required this.image,
    required this.price,
    this.q = 0,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'image': image,
      'price': price,
      'q': q,
    };
  }

  factory Equipment.fromMap(Map<String, dynamic> map) {
    return Equipment(
      name: map['name'] as String,
      image: map['image'] as String,
      price: map['price'] as int,
      q: map['q'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Equipment.fromJson(String source) =>
      Equipment.fromMap(json.decode(source) as Map<String, dynamic>);

  Equipment copyWith({
    String? name,
    String? image,
    int? price,
    int? q,
  }) {
    return Equipment(
      name: name ?? this.name,
      image: image ?? this.image,
      price: price ?? this.price,
      q: q ?? this.q,
    );
  }
}
