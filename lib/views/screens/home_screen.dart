import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sql_project/models/contact.dart';
import 'package:sql_project/views/widgets/add_dialog.dart';
import 'package:sql_project/views/widgets/contact_item.dart';
import 'package:sql_project/controllers/contacts_controller.dart';
import 'package:sql_project/views/widgets/edit_dialog.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final contactsController = ContactsController();

  @override
  void initState() {
    super.initState();
  }

  void deleteContact(int id) {
    contactsController.deleteContact(id);
    setState(() {});
  }

  void editContact(Contact contact) async {
    Map<String, dynamic> data = await showDialog(
        context: context,
        builder: (ctx) => EditDialog(
              contact: contact,
            ));
    contactsController.editContact(
      contact.id,
      data['firstName'],
      data['lastName'],
      data['phoneNumber'],
    );
    setState(() {});
  }

  late int lengthContacts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        bottom: AppBar(
          backgroundColor: Colors.grey[200],
          title: TextField(
            decoration: InputDecoration(
              fillColor: Colors.grey[300],
              filled: true,
              prefixIcon: Icon(
                CupertinoIcons.search,
                color: Colors.grey[700],
                size: 26,
              ),
              hintText: 'Search contacts',
              suffix: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.clear_circled_solid,
                    color: Colors.grey[200],
                  )),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
          ),
        ),
        toolbarHeight: 70,
        backgroundColor: Colors.grey[200],
        title: const Text(
          "Contacts",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              Map<String, dynamic>? data = await showDialog(
                context: context,
                builder: (ctx) => const AddAlertDialog(),
              );
              if (data != null) {
                contactsController.addContact(
                  firstName: data['firstName'],
                  lastName: data['lastName'],
                  phoneNumber: data['phoneNumber'],
                );
                setState(() {});
              }
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder<List<Contact>>(
        future: contactsController.contacts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('An error occurred'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No contacts found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (ctx, index) {
                return ContactItem(
                    contact: snapshot.data![index],
                    delete: deleteContact,
                    edit: editContact);
              },
            );
          }
        },
      ),
    );
  }
}
