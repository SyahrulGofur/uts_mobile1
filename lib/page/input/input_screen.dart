import 'package:flutter/material.dart';

import '../../models/contact_model.dart';
import '../../services/contact_service.dart';

class InputPage extends StatefulWidget {
  final int contactIndex;

  const InputPage({Key? key, required this.contactIndex}) : super(key: key);

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final ContactService _contactService = ContactService();
  TextEditingController _namaController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _telpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.contactIndex != -1) {
      _loadContact();
    }
  }

  void _loadContact() async {
    List<Contact> contactList = await _contactService.getContact();
    Contact contact = contactList[widget.contactIndex];
    _namaController.text = contact.nama;
    _emailController.text = contact.email;
    _telpController.text = contact.telp;
  }

  void _saveContact() async {
    String nama = _namaController.text;
    String email = _emailController.text;
    String telp = _telpController.text;

    Contact newContact = Contact(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      nama: nama,
      email: email,
      telp: telp,
    );

    if (widget.contactIndex == -1) {
      await _contactService.saveContact(newContact);
    } else {
      await _contactService.updateContact(widget.contactIndex, newContact);
    }
    Navigator.pop(context, true);
  }

  void _deleteContact() async {
    bool shouldDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Hapus'),
          content: Text('Anda yakin ingin menghapus kontak ini?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text('Hapus'),
            ),
          ],
        );
      },
    );

    if (shouldDelete == true) {
      await _contactService.deleteContact(widget.contactIndex);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey,
        title: Text('Input Contact'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _deleteContact();
            },
          ),
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveContact();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nama',
                labelText: 'Nama',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _namaController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Email',
                labelText: 'Email',
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _telpController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nomor Telepon',
                labelText: 'Nomor Telepon',
              ),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
      backgroundColor: Colors.grey,
    );
  }
}
