class Field {
  final String uuid;
  final String name;
  final String photo;

  const Field({
    required this.uuid,
    required this.name,
    required this.photo,
  });

  Field copyWith({
    String? uuid,
    String? name,
    String? photo,
  }) {
    return Field(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      photo: photo ?? this.photo,
    );
  }

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      uuid: json['uuid'] ?? '',
      name: json['name'] ?? '',
      photo: json['photo'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'photo': photo,
    };
  }
}
