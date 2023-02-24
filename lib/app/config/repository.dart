import 'package:dio/dio.dart';
import 'package:fields/app/models/user.dart';
import 'package:fields/app/config/config.dart';
import 'package:fields/app/utils/preferences.dart';

class ConfigRepository {
  final Dio dio;
  final Preferences prefs;

  const ConfigRepository({
    required this.dio,
    required this.prefs,
  });

  Future<User> getUserByUuid() async {
    final response = await dio.get('/v1/users/me');

    final user = User.fromJson(response.data);

    AppConfig.user = user;

    return user;
  }
}
