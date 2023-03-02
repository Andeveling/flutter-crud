import 'dart:io';

import 'package:crud_test/services/contact_service.dart';

import '../services/upload_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class NewContactPage extends StatefulWidget {
  const NewContactPage({super.key});
  @override
  State<NewContactPage> createState() => _NewContactPageState();
}

class _NewContactPageState extends State<NewContactPage> {
  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController cellphoneController = TextEditingController(text: '');
  File? _image;
  File? _imageFile;

  Widget _inputText(TextEditingController controller, String text) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: text),
    );
  }

  // This is the image picker
  final _picker = ImagePicker();
  // Implementing the image picker
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      print(pickedImage.path);
      setState(() {
        _image = File(pickedImage.path);
      });
      print(_image);
    }
  }

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
        title: const Text('Add Contact'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            _inputText(nameController, 'Contact Name'),
            _inputText(emailController, 'Contact Email'),
            _inputText(cellphoneController, 'Contact Cellphone'),
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
                                ? Image.network(_image!.path, fit: BoxFit.cover)
                                : Image.file(_image!, fit: BoxFit.cover)
                            : const Text('Please select an image'),
                      )),
                ],
              ),
            ),
            /*     ElevatedButton(
                onPressed: () {
                  createContact( _image)
                      .then((value) => Navigator.pop(context));
                },
                child: const Text('New Contact')), */
            ElevatedButton(
                onPressed: () async {
                  if (_image == null) {
                    return;
                  } else {
                    await uploadImage(_image!)
                        .then((url) => createContact(
                                nameController.text,
                                emailController.text,
                                cellphoneController.text,
                                url)
                            .then((value) => Navigator.pop(context)))
                        .catchError((onError) => print(onError));
                  }
                },
                child: const Text('Create Contact'))
          ],
        ),
      ),
    );
  }
}
