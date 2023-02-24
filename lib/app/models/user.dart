import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String uuid;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String photo;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.uuid,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.photo,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  User copyWith({
    String? uuid,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? photo,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return User(
      uuid: uuid ?? this.uuid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photo: photo ?? this.photo,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uuid: json['uuid'],
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      photo: json['photo'] ?? '',
      status: json['status'] ?? '',
      createdAt: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']) ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'photo': photo,
      'status': status,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  @override
  List<Object?> get props {
    return [
      uuid,
      firstName,
      lastName,
      email,
      phone,
      photo,
      status,
      createdAt,
      updatedAt,
    ];
  }
}
