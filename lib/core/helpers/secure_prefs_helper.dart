import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/user.dart';

class SecurePrefHelper {
  final storage = FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await storage.write(key: 'token', value: token);
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<void> saveRefreshToken(String refToken) async {
    await storage.write(key: 'refToken', value: refToken);
  }

  Future<String?> getRefToken() async {
    return await storage.read(key: 'refToken');
  }

  Future<void> clear() async {
    await storage.deleteAll();
  }
}
