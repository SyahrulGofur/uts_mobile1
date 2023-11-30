import 'package:flutter/material.dart';

import '../models/contact_model.dart';
import '../services/contact_service.dart';
import 'input/input_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TextField(
          controller: _searchController,
          onChanged: _onSearchTextChanged,
          decoration: InputDecoration(
            hintText: 'Search',
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _contactList.length,
        itemBuilder: (context, index) {
          String nama = '${_contactList[index].nama}';
          String email = '${_contactList[index].email}';
          String telp = '${_contactList[index].telp}';

          return GestureDetector(
              onTap: () {
                _navigateToInputPage(index);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/profile.png'),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(nama,
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(email),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(telp),
                          ],
                        ),
                        Divider(),
                      ],
                    ),
                  ],
                ),
              ));
        },
      ),
    );
  }

  void _onSearchTextChanged(String value) async {
    List<Contact> searchedContact = await _contactService.searchContact(value);
    setState(() {
      _contactList = searchedContact;
    });
  }

  void _navigateToInputPage(int id) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => InputPage(contactIndex: id),
      ),
    );
    _loadContact();
  }
}
