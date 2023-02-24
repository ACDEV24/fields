import 'package:fields/app/models/product.dart';

class Category {
  final String uuid;
  final String name;
  final String description;
  final List<Product> products;

  Category({
    required this.uuid,
    required this.name,
    required this.description,
    required this.products,
  });

  Category copyWith({
    String? uuid,
    String? name,
    String? description,
    List<Product>? products,
  }) {
    return Category(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      description: description ?? this.description,
      products: products ?? this.products,
    );
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      uuid: json['uuid'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      products:
          (json['products'] as List).map((e) => Product.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'description': description,
      'products': products.map((e) => e.toJson()).toList(),
    };
  }
}
