import 'package:fields/app/models/category.dart';

class Product {
  final String uuid;
  final String name;
  final String description;
  final String providerUuid;
  final double sellPrice;
  final double buyPrice;
  final String subtype;
  final String gender;
  final String photo;
  final String categoryUuid;
  final Category? category;

  Product({
    required this.uuid,
    required this.name,
    required this.description,
    required this.providerUuid,
    required this.sellPrice,
    required this.buyPrice,
    required this.subtype,
    required this.gender,
    required this.photo,
    required this.categoryUuid,
    required this.category,
  });

  Product copyWith({
    String? uuid,
    String? name,
    String? description,
    String? providerUuid,
    double? sellPrice,
    double? buyPrice,
    String? subtype,
    String? gender,
    String? photo,
    String? categoryUuid,
    Category? category,
  }) {
    return Product(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      description: description ?? this.description,
      providerUuid: providerUuid ?? this.providerUuid,
      sellPrice: sellPrice ?? this.sellPrice,
      buyPrice: buyPrice ?? this.buyPrice,
      subtype: subtype ?? this.subtype,
      gender: gender ?? this.gender,
      photo: photo ?? this.photo,
      categoryUuid: categoryUuid ?? this.categoryUuid,
      category: category ?? this.category,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      uuid: json['uuid'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      providerUuid: json['provider_uuid'] ?? '',
      sellPrice: json['sell_price']?.toDouble() ?? 0.0,
      buyPrice: json['buy_price']?.toDouble() ?? 0.0,
      subtype: json['subtype'] ?? '',
      gender: json['gender'] ?? '',
      photo: json['photo'] ?? '',
      categoryUuid: json['category_uuid'] ?? '',
      category:
          json['category'] == null ? null : Category.fromJson(json['category']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'description': description,
      'provider_uuid': providerUuid,
      'sell_price': sellPrice,
      'buy_price': buyPrice,
      'subtype': subtype,
      'gender': gender,
      'photo': photo,
      'category_uuid': categoryUuid,
      'category': category?.toJson(),
    };
  }
}
