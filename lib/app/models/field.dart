class Field {
  final String uuid;
  final String name;
  final String description;
  final String image;
  final double price;
  final int numReservations;

  const Field({
    required this.uuid,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    this.numReservations = 0,
  });

  Field copyWith({
    String? uuid,
    String? name,
    String? description,
    String? image,
    double? price,
    int? numReservations,
  }) {
    return Field(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      price: price ?? this.price,
      numReservations: numReservations ?? this.numReservations,
    );
  }

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      uuid: json['uuid'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      price: json['price'] ?? 0.0,
      numReservations: json['num_reservations'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'image': image,
      'price': price,
      'num_reservations': numReservations,
    };
  }
}
