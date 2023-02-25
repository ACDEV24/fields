import 'package:fields/app/models/field.dart';

class Bookings {
  final String uuid;
  final String userName;
  final String fieldUuid;
  final Field field;
  final DateTime date;

  const Bookings({
    required this.uuid,
    required this.userName,
    required this.fieldUuid,
    required this.date,
    required this.field,
  });

  Bookings copyWith({
    String? uuid,
    String? userName,
    String? fieldUuid,
    DateTime? date,
    Field? field,
  }) {
    return Bookings(
      uuid: uuid ?? this.uuid,
      userName: userName ?? this.userName,
      fieldUuid: fieldUuid ?? this.fieldUuid,
      date: date ?? this.date,
      field: field ?? this.field,
    );
  }

  factory Bookings.fromJson(Map<String, dynamic> json) {
    return Bookings(
      uuid: json['uuid'] ?? '',
      userName: json['user_name'] ?? '',
      fieldUuid: json['field_uuid'] ?? '',
      date: DateTime.tryParse(json['date']) ?? DateTime.now(),
      field: Field.fromJson(json['field'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'user_name': userName,
      'field_uuid': fieldUuid,
      'date': date,
      'field': field.toJson(),
    };
  }
}
