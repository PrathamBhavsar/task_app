import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:task_app/constants/supabase_keys.dart';
import 'package:task_app/extensions/color_extension.dart';
import 'package:task_app/models/user.dart';
import 'dart:convert';

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

      await _saveLoginState(context, user); // Save whole UserModel
      context.goNamed('home');
    } catch (error) {
      logger.e("Error during signUp: $error");
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  Future<void> createRowEntry(UserModel user) async {
    try {
      await supabase.from(SupabaseKeys.usersTable).insert(user.toJson());
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

      final user = await fetchUserFromDb(res.user!.id);
      await _saveLoginState(context, user!);
    } catch (error) {
      logger.e("Error during login: $error");
      Fluttertoast.showToast(msg: error.toString());
    }
  }

  Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('user');
    await supabase.auth.signOut();
    context.goNamed('signup');
  }

  Future<void> _saveLoginState(BuildContext context, UserModel user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('user', jsonEncode(user.toJson()));
    context.goNamed('home');
  }

  Future<UserModel?> fetchUserFromDb(String userId) async {
    try {
      final response = await supabase
          .from(SupabaseKeys.usersTable)
          .select()
          .eq(SupabaseKeys.id, userId)
          .single();

      if (response.isNotEmpty) {
        return UserModel.fromJson(response);
      }
    } catch (error) {
      logger.e("Error fetching user: $error");
    }
    return null;
  }

  Future<UserModel?> getLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');

    if (userJson != null) {
      return UserModel.fromJson(jsonDecode(userJson));
    }
    return null;
  }
}
