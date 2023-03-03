import 'package:crud_test/widgets/contact_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHomePage> {
  final User? user = Auth().currentUser;
  Future<void> signOut() async {
    await Auth().signOut();
  }

  final ButtonStyle styleDelete = ElevatedButton.styleFrom(
    backgroundColor: Colors.red,
    textStyle: const TextStyle(fontSize: 20),
  );

  final ButtonStyle styleCancel = ElevatedButton.styleFrom(
    backgroundColor: Colors.grey.shade800,
    textStyle: const TextStyle(fontSize: 20),
  );
  Widget _text() => Text(
        'Contact List',
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      );
  Widget _title() => const Text('Firebase App - Contacts');
  Widget _space() => const SizedBox(height: 10);
  Widget _signOutButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Confirm?"),
                content: const Text("Do you want to close the section?"),
                actions: <Widget>[
                  ElevatedButton(
                    style: styleCancel,
                    child: const Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  ElevatedButton(
                    style: styleDelete,
                    child: const Text("Close"),
                    onPressed: () async {
                      signOut();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        },
        child: const Text('Sign Out'));
  }

  Widget _userUid() => Text(user?.email ?? 'User Email');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [_userUid()],
                ),
                Column(
                  children: [_signOutButton()],
                ),
              ],
            ),
            _text(),
            _space(),
            _space(),
            const ContactList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
