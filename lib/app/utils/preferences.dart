import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fields/app/models/token.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Preferences._privateConstructor();

  static final Preferences _instance = Preferences._privateConstructor();

  factory Preferences() => _instance;

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Token? get token {
    final value = _prefs?.getString('token');

    if (value != null) {
      final tokenData = json.decode(value);
      final token = Token.fromJson(tokenData);

      return token;
    }

    return null;
  }

  set token(Token? value) {
    final token = json.encode(value?.toJson() ?? {});

    _prefs?.setString('token', token);

    Modular.get<Dio>().options.headers['Authorization'] =
        'Bearer ${value?.accessToken}';
  }

  String get userUuid => _prefs?.getString('userUuid') ?? '';
  set userUuid(String value) => _prefs?.setString('userUuid', value);

  bool get loggedWithGoogle => _prefs?.getBool('loggedWithGoogle') ?? false;
  set loggedWithGoogle(bool value) =>
      _prefs?.setBool('loggedWithGoogle', value);

  bool get alreadySelectCurrent =>
      _prefs?.getBool('alreadySelectCurrent') ?? false;
  set alreadySelectCurrent(bool value) =>
      _prefs?.setBool('alreadySelectCurrent', value);

  bool get isLogged => token != null;

  Future<void> clear() async {
    await _prefs?.clear();
  }
}
