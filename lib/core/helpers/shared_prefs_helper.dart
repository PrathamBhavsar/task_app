import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/user.dart';

class SharedPrefHelper {
  late SharedPreferences _prefs;

  SharedPrefHelper() {
    init();
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveUser(User user) async {
    final jsonString = jsonEncode(user.toJson());
    await _prefs.setString('user', jsonString);
  }

  Future<User?> getUser() async {
    final jsonString = _prefs.getString('user');
    if (jsonString == null) {
      return null;
    }
    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    return User.fromJson(jsonMap);
  }

  Future<void> clear() async {
    await _prefs.clear();
  }
}
