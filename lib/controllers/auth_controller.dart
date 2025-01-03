import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_app/constants/supabase_keys.dart';
import 'package:task_app/extensions/color_extension.dart';
import 'package:task_app/models/user.dart';

class AuthController {
  static final AuthController instance = AuthController._privateConstructor();
  AuthController._privateConstructor();

  final supabase = Supabase.instance.client;
  var logger = Logger();

  Future<void> signUp({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      final profileBgColor = RandomColorString.generateRandomColorString();

      UserModel user = UserModel(
        id: res.user?.id ?? null,
        name: name,
        email: email,
        profileBgColor: profileBgColor,
        role: role,
      );

      await createRowEntry(user);

      await _saveLoginState(context, res.user!.id);
      context.goNamed('home');
    } catch (error) {
      logger.e("Error during signUp: $error");
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  Future<void> createRowEntry(UserModel user) async {
    try {
      await supabase.from(SupabaseKeys.usersTable).insert(user);
    } catch (error) {
      logger.e("Error inserting user: $error");
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  Future<void> login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      await _saveLoginState(context, res.user!.id);
    } catch (error) {
      logger.e("Error during login: $error");
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('userId');
    await supabase.auth.signOut();
  }

  Future<void> _saveLoginState(BuildContext context, String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('userId', userId);
    context.goNamed('home');
  }
}
