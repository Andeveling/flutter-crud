import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  final _formKey = GlobalKey<FormState>();
  late String _email, _name, _cellphone;
  File? _image;
  // This is the image picker
  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  CollectionReference contacts =
      FirebaseFirestore.instance.collection('contacts');

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Aquí puedes enviar los datos del usuario a un servidor o una base de datos
    }
  }

  Widget _submitButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            backgroundColor: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
        onPressed: _submitForm,
        child: const Text('Create Contact'));
  }

  Widget _title() => const Text('Add a new contact');
  Widget _textHeader() => Text(
        'Add a new contact',
        style: GoogleFonts.poppins(
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _title(),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(35),
            child: Column(children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _textHeader(),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                        onTap: _openImagePicker,
                        child: Container(
                          alignment: Alignment.center,
                          width: 300,
                          height: 200,
                          color: Colors.grey[300],
                          child: _image != null
                              ? kIsWeb
                                  ? Image.network(_image!.path,
                                      fit: BoxFit.cover)
                                  : Image.file(_image!, fit: BoxFit.cover)
                              : const Text('Please select an image'),
                        )),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _name = value!;
                      },
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value!;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Cellphone',
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your cellphone number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _cellphone = value!;
                      },
                    ),
                    const SizedBox(height: 16),
                    _submitButton()
                  ],
                ),
              ),
              // The picked image will be displayed here
            ]),
          ),
        ));
  }
}
