import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  Preferences._privateConstructor();

  static final Preferences _instance = Preferences._privateConstructor();

  factory Preferences() => _instance;

  SharedPreferences? _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> clear() async {
    await _prefs?.clear();
  }
}
