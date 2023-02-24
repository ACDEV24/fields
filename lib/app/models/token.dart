import 'package:equatable/equatable.dart';

class Token extends Equatable {
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAt;

  const Token({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAt,
  });

  Token copyWith({
    String? accessToken,
    String? refreshToken,
    DateTime? expiresAt,
  }) {
    return Token(
      accessToken: accessToken ?? this.accessToken,
      refreshToken: refreshToken ?? this.refreshToken,
      expiresAt: expiresAt ?? this.expiresAt,
    );
  }

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      expiresAt: DateTime.parse(json['expires_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'refresh_token': refreshToken,
      'access_token': accessToken,
      'expires_at': expiresAt.toIso8601String(),
    };
  }

  @override
  List<Object> get props {
    return [
      accessToken,
      refreshToken,
      expiresAt,
    ];
  }
}
