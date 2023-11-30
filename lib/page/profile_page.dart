import 'package:flutter/material.dart';
import 'package:mobileutssyahrul/services/session_service.dart';

import 'auth/login_page.dart';


class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final SessionService _sessionService = SessionService();

  String _username = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _loadSessionData();
  }

  void _loadSessionData() async {
    Map<String, dynamic>? sessionData = await _sessionService.getSession();
    if (sessionData != null) {
      setState(() {
        _username = sessionData['username'];
        _email = sessionData['email'];
      });
    }
  }

  void _logout() async {
    await _sessionService.logout(context);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/profile.png'),
            ),
            SizedBox(height: 16),
            Text(
              _username.isNotEmpty ? _username : 'Not logged in yet',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              _email.isNotEmpty ? _email : 'Not logged in yet',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _logout,
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
