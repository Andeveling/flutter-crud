// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:crud_test/services/contact_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateContactPage extends StatefulWidget {
  const UpdateContactPage({super.key});

  @override
  State<UpdateContactPage> createState() => _UpdateContactPageState();
}

class _UpdateContactPageState extends State<UpdateContactPage> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController cellphoneController = TextEditingController(text: '');
  TextEditingController imageUrlController = TextEditingController(text: '');

  Widget _inputText(TextEditingController controller, String text) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: text),
    );
  }

  Widget _space() => const SizedBox(
        height: 20,
      );

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    final ButtonStyle styleDelete = ElevatedButton.styleFrom(
      backgroundColor: Colors.red,
      textStyle: const TextStyle(fontSize: 20),
    );

    final ButtonStyle styleCancel = ElevatedButton.styleFrom(
      backgroundColor: Colors.grey.shade800,
      textStyle: const TextStyle(fontSize: 20),
    );

    final Map arguments = ModalRoute.of(context)?.settings.arguments as Map;
    final id = arguments['id'];
    nameController.text = arguments['name'];
    emailController.text = arguments['email'];
    cellphoneController.text = arguments['cellphone'];

    Widget _avatar() => CircleAvatar(
        minRadius: 100, backgroundImage: NetworkImage(arguments['imageUrl']));

    Widget _text() => Text(
          '${arguments['name']}',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        );

    Widget _textEdit() => Text(
          'Edit Info',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        );

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Update User'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                _space(),
                _text(),
                _space(),
                _space(),
                _avatar(),
                _space(),
                _textEdit(),
                _inputText(nameController, 'Contact Name'),
                _inputText(emailController, 'Contact Email'),
                _inputText(cellphoneController, 'Contact Cellphone'),
                _space(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        ElevatedButton(
                            style: style,
                            onPressed: () async {
                              if (nameController.text != null &&
                                  emailController.text != null &&
                                  cellphoneController.text != null) {
                                await updateContact(
                                  id,
                                  nameController.text,
                                  emailController.text,
                                  cellphoneController.text,
                                );
                                Navigator.pop(context);
                              } else {
                                // Mostrar un mensaje de error
                              }
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.upload), // El icono a mostrar
                                SizedBox(width: 8), Text('Update')
                              ],
                            )),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
