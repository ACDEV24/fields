import 'package:flutter_modular/flutter_modular.dart';
import 'package:fields/app/models/user.dart';
import 'package:fields/app/config/bloc/bloc.dart';
export 'package:fields/app/config/bloc/bloc.dart';
import 'package:fields/app/utils/preferences.dart';
import 'package:logger/logger.dart';

class AppConfig {
  static const isProd = bool.fromEnvironment('dart.vm.product');
  static const name = 'fields';
  static final _prefs = Preferences();
  static const baseUrl = isProd
      ? 'http://157.245.243.176:3000/api'
      : 'http://157.245.243.176:3000/api';
  // : 'http://192.168.1.10:3000/api';
  static String version = '';

  static User? _user;
  static User? get user => _user;
  static set user(User? user) {
    _prefs.userUuid = user?.uuid ?? '';

    Modular.get<ConfigBloc>().add(ChangeUserEvent(user));

    _user = user;
  }

  static void logout() async {
    user = null;
    await _prefs.clear();
    Modular.to.navigate('/');
    await Future.delayed(const Duration(milliseconds: 500));
    Modular.get<ConfigBloc>().add(const InitEvent());
  }

  static void logError(error, [stackTrace]) {
    final logger = Logger();
    logger.e([error, stackTrace], error);
  }
}
