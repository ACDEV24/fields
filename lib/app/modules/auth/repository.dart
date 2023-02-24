import 'package:dio/dio.dart';
import 'package:fields/app/models/token.dart';
import 'package:fields/app/models/user.dart';
import 'package:fields/app/utils/preferences.dart';

class AuthRepository {
  final Dio dio;
  final Preferences prefs;

  const AuthRepository({
    required this.dio,
    required this.prefs,
  });

  Future<void> sendCode(String phone) async {
    await dio.post(
      '/guest/v1/users/code',
      data: {
        'phone': phone,
      },
    );
  }

  Future<User> validateCode(String phone, String code) async {
    final response = await dio.post(
      '/guest/v1/users/code/validate',
      data: {
        'phone': phone,
        'code': code,
      },
    );

    prefs.token = Token.fromJson(response.data['token']);

    final user = User.fromJson(response.data['user']);

    return user;
  }

  Future<User> googleLogin(String token, String photo) async {
    final response = await dio.post(
      '/guest/v1/users/google',
      data: {
        'token': token,
        'phone': photo,
      },
    );

    prefs.token = Token.fromJson(response.data['token']);

    final user = User.fromJson(response.data['user']);

    return user;
  }
}
