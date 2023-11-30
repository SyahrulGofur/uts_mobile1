import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/contact_model.dart';

class ContactService {
  final String key = 'contact';
  Future<List<Contact>> getContact() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? contactString = prefs.getString(key);
    if (contactString != null) {
      List<dynamic> contactJson = jsonDecode(contactString);
      return contactJson.map((json) => Contact.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<void> saveContact(Contact contacts) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Contact> contactList = await getContact();
    contactList.add(contacts);
    String notesString =
        jsonEncode(contactList.map((contact) => contact.toJson()).toList());
    prefs.setString(key, notesString);
  }

  Future<void> updateContact(int index, Contact updatedContact) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Contact> contactList = await getContact();
    contactList[index] = updatedContact;
    String contactString =
        jsonEncode(contactList.map((contact) => contact.toJson()).toList());
    prefs.setString(key, contactString);
  }

  Future<void> deleteContact(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<Contact> contactList = await getContact();
    contactList.removeAt(index);
    String contactString =
        jsonEncode(contactList.map((contact) => contact.toJson()).toList());
    prefs.setString(key, contactString);
  }

  Future<List<Contact>> searchContact(String query) async {
    List<Contact> contactList = await getContact();
    return contactList.where((contact) {
      return contact.nama.toLowerCase().contains(query.toLowerCase()) ||
          contact.email.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
