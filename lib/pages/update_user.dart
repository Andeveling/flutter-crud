import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../firebase_service.dart';

class UpdateUserPage extends StatefulWidget {
  const UpdateUserPage({super.key});

  @override
  State<UpdateUserPage> createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  TextEditingController nameController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    nameController.text = arguments['name'];
    return Scaffold(
        appBar: AppBar(
          title: const Text('Update User'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(hintText: 'Enter Name'),
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (kDebugMode) {
                      print(nameController.text);
                    }
                    await addUser(nameController.text)
                        .then((value) => Navigator.pop(context));
                  },
                  child: const Text('Update User'))
            ],
          ),
        ));
  }
}
