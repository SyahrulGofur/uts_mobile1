import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/account_model.dart';
import '../page/auth/login_page.dart';

class SessionService {
  final String sessionKey = 'loggedIn';
  Future<void> saveSession(Akun akun) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('sessionUserId', akun.id);
    prefs.setString('sessionName', akun.nama);
    prefs.setString('sessionEmail', akun.email);
  }

  Future<Map<String, dynamic>?> getSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('sessionUserId');
    String? username = prefs.getString('sessionName');
    String? email = prefs.getString('sessionEmail');

    if (userId != null && username != null && email != null) {
      return {'userId': userId, 'username': username, 'email': email};
    } else {
      return null;
    }
  }

  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('sessionUserId');
    await prefs.remove('sessionName');
    await prefs.remove('sessionEmail');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }
}
