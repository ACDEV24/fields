class Field {
  final String uuid;
  final String name;
  final String description;
  final String image;
  final double price;

  const Field({
    required this.uuid,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
  });

  Field copyWith({
    String? uuid,
    String? name,
    String? description,
    String? image,
    double? price,
  }) {
    return Field(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
    );
  }

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      uuid: json['uuid'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      price: json['price'] ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'image': image,
      'price': price,
    };
  }
}
