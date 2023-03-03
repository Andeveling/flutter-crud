import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/contact_service.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: contactsRef.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text('You have no contacts'),
          );
        }
        return Expanded(
          child: ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (BuildContext context, int index) {
              final doc = snapshot.data!.docs[index];
              final contact = {
                'id': doc.id,
                'name': doc['name'],
                'cellphone': doc['cellphone'],
                'email': doc['email'],
                'imageUrl': doc['imageUrl'],
              };
              return Dismissible(
                key: Key(contact['id']),
                background: Container(
                  color: Colors.red,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                onDismissed: (direction) async {
                  await deleteContact(doc.id);
                },
                confirmDismiss: (direction) async {
                  var result = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(
                              'Are you sure you want to delete the contact?'),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancel')),
                            TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Yes')),
                          ],
                        );
                      });
                  return result;
                },
                direction: DismissDirection.startToEnd,
                child: ListTile(
                  title: Text(contact['name']),
                  subtitle: Text(contact['cellphone']),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(contact['imageUrl']),
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/update', arguments: {
                      'id': contact['id'],
                      'name': contact['name'],
                      'cellphone': contact['cellphone'],
                      'email': contact['email'],
                      'imageUrl': contact['imageUrl'],
                    });
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
