/* import 'package:crud_test/services/contact_service.dart';
import 'package:flutter/material.dart';
import '../firebase_service.dart';
import 'package:crud_test/models/contact_model.dart';

class ContactListWidget extends StatefulWidget {
  const ContactListWidget({Key? key}) : super(key: key);
  @override
  State<ContactListWidget> createState() => _ContactListWidgetState();
}

class _ContactListWidgetState extends State<ContactListWidget> {
  late List<ContactModel> _contacts;

  @override
  void initState() {
    super.initState();
    _contacts = [];
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    List<ContactModel> contacts = await getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.value(getAllUsers()),
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        return ListView.builder(
          itemCount: snapshot.data?.length ?? 0,
          itemBuilder: (BuildContext context, int index) {
            final user = snapshot.data?[index];
            return ListTile(
              title: Text(user?['name'] ?? ''),
              subtitle: Text(user?['email'] ?? ''),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user['imageUrl']),
              ),
              onTap: (() {
                Navigator.pushNamed(context, '/update',
                    arguments: {'name': snapshot.data?[index]['name']});
              }),
            );
          },
        );
      }),
    );
  }
}
 */