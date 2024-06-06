import 'package:sql_project/models/contact.dart';
import 'package:sql_project/services/local_database.dart';

class ContactsController {
  LocalDatabase localDatabase = LocalDatabase();

  List<Contact> _contacts = [];

  Future<List<Contact>> get contacts async {
    await localDatabase.database;
    _contacts = await localDatabase.getContacts();
    return [..._contacts];
  }

  void addContact({
    required String firstName,
    String? lastName,
    required String phoneNumber,
  }) {
    localDatabase.addContact(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
    );
  }

  void deleteContact(int id) {
    localDatabase.deleteContact(id);
  }

  void editContact(
      int id, String firstName, String lastName, String phoneNumber) {
    localDatabase.editContact(id, firstName, lastName, phoneNumber);
  }
}
