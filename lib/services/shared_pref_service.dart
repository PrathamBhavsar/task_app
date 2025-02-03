import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static final SharedPrefService _instance = SharedPrefService._internal();
  late SharedPreferences _prefs;

  SharedPrefService._internal();

  factory SharedPrefService() => _instance;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool isLoggedIn() => _prefs.getBool("isLoggedIn") ?? false;

  Future<void> setLoggedIn(bool value) async =>
      await _prefs.setBool("isLoggedIn", value);

  /// Save and get user data as JSON string
  Future<void> saveUser(String userJson) async =>
      await _prefs.setString("user", userJson);
  String? getUser() => _prefs.getString("user");

  /// Clear all stored data
  Future<void> clear() async => await _prefs.clear();
}
