import 'package:fields/app/models/field.dart';

class Reservation {
  final String uuid;
  final String userName;
  final String fieldUuid;
  final Field field;
  final DateTime date;

  const Reservation({
    required this.uuid,
    required this.userName,
    required this.fieldUuid,
    required this.date,
    required this.field,
  });

  Reservation copyWith({
    String? uuid,
    String? userName,
    String? fieldUuid,
    DateTime? date,
    Field? field,
  }) {
    return Reservation(
      uuid: uuid ?? this.uuid,
      userName: userName ?? this.userName,
      fieldUuid: fieldUuid ?? this.fieldUuid,
      date: date ?? this.date,
      field: field ?? this.field,
    );
  }

  factory Reservation.fromJson(Map<String, dynamic> json) {
    return Reservation(
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
