import 'package:flutter/material.dart';

import '../models/contact_model.dart';
import '../services/contact_service.dart';
import 'input/input_screen.dart';
import 'profile_page.dart';
import 'search_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SearchPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: Text('ContactApp'),
        ),
        backgroundColor: Colors.grey,
        automaticallyImplyLeading: false,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        backgroundColor: Colors.grey,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Contact> _contactList = [];
  final ContactService _contactService = ContactService();

  @override
  void initState() {
    super.initState();
    _loadContact();
  }

  void _loadContact() async {
    List<Contact> contactList = await _contactService.getContact();
    setState(() {
      _contactList = contactList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          String nama = _contactList[index].nama;
          String email = _contactList[index].email;
          String telp = _contactList[index].telp;

          return GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InputPage(contactIndex: index)),
              );
              _loadContact();
            },
            child: Card(
              color: Colors.grey,
              margin: EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/profile.png'),
                    ),
                    Text(
                      nama,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(email),
                    Text(telp),
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: _contactList.length,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => InputPage(contactIndex: -1)),
          );
          _loadContact();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
