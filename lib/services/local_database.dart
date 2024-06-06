import 'package:sqflite/sqflite.dart';
import 'package:sql_project/models/contact.dart';

class LocalDatabase {
  LocalDatabase._singleton();

  static final LocalDatabase _localDatabase = LocalDatabase._singleton();

  factory LocalDatabase() {
    return _localDatabase;
  }

  Database? _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = '$databasePath/contact.db';
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    return await db.execute("""
     CREATE TABLE contacts (
       id INTEGER PRIMARY KEY AUTOINCREMENT,
       first_name TEXT NOT NULL, 
       last_name TEXT,
       phone_number TEXT NOT NULL
      )
    """);
  }

  Future<void> addContact(
      {required String firstName,
      required String? lastName,
      required String phoneNumber}) async {
    await _database!.insert('contacts', {
      'first_name': firstName,
      'last_name': lastName,
      'phone_number': phoneNumber,
    });
  }

  Future<List<Contact>> getContacts() async {
    try {
      final data = await _database!.query('contacts');
      print(data);
      List<Contact> contacts = [];
      for (var row in data) {
        contacts.add(Contact.fromJson(row));
      }
      return contacts;
    } catch (e) {
      print(e);
    }

    return [];
  }

  Future<void> deleteContact(int id) async {
    if (_database != null) {
      var data = await _database!.delete('contacts', where: 'id = $id');
      print(data);
    }
  }

  Future<void> editContact(
    int id,
    String firstName,
    String lastName,
    String phoneNumber,
  ) async {
    await _database!.update(
        'contacts',
        {
          'first_name': firstName,
          'last_name': lastName,
          'phone_number': phoneNumber,
        },
        where: 'id = $id');
  }
}
