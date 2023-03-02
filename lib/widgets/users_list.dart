/* import 'package:flutter/material.dart';
import '../firebase_service.dart';
import '../services/contact_service.dart';
import 'package:crud_test/models/contact_model.dart';

class UserListWidget extends StatefulWidget {
  const UserListWidget({Key? key}) : super(key: key);
  @override
  State<UserListWidget> createState() => _UserListWidgetState();
}

class _UserListWidgetState extends State<UserListWidget> {
  late List<ContactModel> _contacts;
  late FirebaseService _firebaseService;

  @override
  void initState() {
    super.initState();
    _users = [];
    _firebaseService = FirebaseService();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    List<UserModel> users = await _firebaseService.readUsers();
    setState(() {
      _users = users;
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