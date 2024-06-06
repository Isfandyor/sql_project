import 'package:flutter/material.dart';

class AddAlertDialog extends StatefulWidget {
  const AddAlertDialog({super.key});

  @override
  State<AddAlertDialog> createState() => _AddAlertDialogState();
}

class _AddAlertDialogState extends State<AddAlertDialog> {
  final formKey = GlobalKey<FormState>();

  String? firstName;
  String? lastName;
  String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 80),
        child: Text(
          "New Contact",
          maxLines: 1,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
        ),
      ),
      content: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            TextFormField(
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your first name';
                }
                return null;
              },
              onSaved: (newValue) {
                firstName = newValue;
              },
              decoration: const InputDecoration(
                label: Text(
                  "First name",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              onSaved: (newValue) {
                lastName = newValue;
              },
              decoration: const InputDecoration(
                label: Text(
                  "Last Name",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextFormField(
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter your phone number';
                }
                return null;
              },
              onSaved: (newValue) {
                phoneNumber = newValue;
              },
              decoration: const InputDecoration(
                label: Text(
                  "Phone Number",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Cancel",
            style: TextStyle(fontSize: 18),
          ),
        ),
        TextButton(
          onPressed: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              Navigator.pop(
                context,
                {
                  "firstName": firstName!,
                  "lastName": lastName,
                  "phoneNumber": phoneNumber!,
                },
              );
            }
          },
          child: const Text(
            "Create",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }
}
