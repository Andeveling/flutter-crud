import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../auth.dart';

final contactsRef = FirebaseFirestore.instance.collection('contacts');
final storageRef = FirebaseStorage.instance.ref();

// UploadImage
Future<String> uploadImages(File image) async {
  String url = '';
  try {
// Create a reference to "mountains.jpg"
    final contactRef = storageRef.child(image.path);
    url = await contactRef.getDownloadURL();
    return url;
// Listen for state changes, errors, and completion of the upload.
  } on FirebaseException catch (e) {
    print(e.message);
  }
  return url;
}

// Create Contact
Future<void> createContact(name, email, cellphone, image) async {
  String imageUrl = await uploadImages(image);
  try {
    await contactsRef.add({
      'userId': Auth().currentUser!.uid,
      'name': name,
      'email': email,
      'cellphone': cellphone,
      'imageUrl': imageUrl,
    });
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }
}

// Read
Future<List<DocumentSnapshot<Object?>>> getContacts() async {
  QuerySnapshot querySnapshot = await contactsRef
      .where('userId', isEqualTo: Auth().currentUser!.uid)
      .get();
  List<DocumentSnapshot> documents = querySnapshot.docs;
  return documents;
}
