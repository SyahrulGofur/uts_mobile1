import 'package:flutter/material.dart';
import 'package:mobileutssyahrul/page/auth/register_page.dart';
import 'package:mobileutssyahrul/page/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'page/auth/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? sessionId = prefs.getString('sessionUserId');

  runApp(MyApp(initialRoute: sessionId != null ? '/home' : '/login'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({required this.initialRoute, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: initialRoute,
      routes: {
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => HomeScreen(),
      },
      home: LoginPage(),
    );
  }
}
