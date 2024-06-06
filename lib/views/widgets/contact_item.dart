import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sql_project/models/contact.dart';

// ignore: must_be_immutable
class ContactItem extends StatefulWidget {
  Contact contact;
  Function(int) delete;
  Function(Contact) edit;
  ContactItem({
    super.key,
    required this.delete,
    required this.contact,
    required this.edit,
  });

  @override
  State<ContactItem> createState() => _ContactItemState();
}

class _ContactItemState extends State<ContactItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Colors.grey[400],
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        minLeadingWidth: 60,
        leading: CircleAvatar(
          backgroundColor: Colors.primaries[Random().nextInt(17)],
          radius: 30,
          child: Center(
            child: Text(
              widget.contact.firstName[0],
              style: const TextStyle(fontSize: 20),
            ),
          ),
        ),
        title: SizedBox(
          width: 100,
          child: Row(
            children: [
              Text(
                widget.contact.firstName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  widget.contact.lastName,
                  maxLines: 1,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        subtitle: Text(
          widget.contact.phoneNumber,
          style: const TextStyle(fontSize: 17),
        ),
        trailing: PopupMenuButton(
          onSelected: (value) {
            if (value == 1) {
              widget.delete(widget.contact.id);
            } else if (value == 0) {
              widget.edit(widget.contact);
            }
          },
          itemBuilder: (ctx) {
            return [
              const PopupMenuItem(
                value: 0,
                child: Text(
                  "Edit",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Text(
                  "Delete",
                  style: TextStyle(color: Colors.red[900]),
                ),
              ),
            ];
          },
        ),
      ),
    );
  }
}
