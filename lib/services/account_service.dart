import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/account_model.dart';

class AccountService {
  final String sessionKey = 'loggedIn';
  final String key = 'akun';

  Future<bool> saveAkun(Akun akun, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String akunData = prefs.getString(key) ?? '';
    List<Map<String, dynamic>> akunList = [];

    if (akunData.isNotEmpty) {
      akunList =
          (jsonDecode(akunData) as List<dynamic>).cast<Map<String, dynamic>>();
    }

    if (akunList.any((existingAkun) => existingAkun['email'] == akun.email)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Email sudah terdaftar.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return false;
    }

    Map<String, dynamic> userData = {
      'id': akun.id,
      'nama': akun.nama,
      'email': akun.email,
      'password': akun.password,
    };
    akunList.add(userData);

    prefs.setString(key, json.encode(akunList));

    return true;
  }

  Future<List<Akun>> getAkunList() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> akunStrings = prefs.getStringList(key) ?? [];
    return akunStrings.map((akunString) {
      final Map<String, dynamic> akunMap = jsonDecode(akunString);
      return Akun.fromJson(akunMap);
    }).toList();
  }

  Future<Akun?> getAkunByUsername(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String akunData = prefs.getString(key) ?? '';
    List<Map<String, dynamic>> akunList = [];

    if (akunData.isNotEmpty) {
      akunList =
          (jsonDecode(akunData) as List<dynamic>).cast<Map<String, dynamic>>();
    }

    Map<String, dynamic>? userData;
    for (var existingAkun in akunList) {
      if (existingAkun['email'] == email) {
        userData = existingAkun;
        break;
      }
    }

    if (userData != null) {
      return Akun.fromJson(userData);
    }

    return null;
  }
}
