import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../auth.dart';

final contactsRef = FirebaseFirestore.instance.collection('contacts');
final storageRef = FirebaseStorage.instance.ref();

// Create Contacts
Future<void> createContact(name, email, cellphone, image) async {
  try {
    await contactsRef.add({
      'userId': Auth().currentUser!.uid,
      'name': name,
      'email': email,
      'cellphone': cellphone,
      'imageUrl': image,
    });
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }
}

// Read Contacts
Future<List> getAllContacts() async {
  List contacts = [];
  QuerySnapshot querySnapshot = await contactsRef.get();
  List<DocumentSnapshot> documents = querySnapshot.docs;
  for (var doc in documents) {
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final contact = {
      'id': doc.id,
      'name': data['name'],
      'cellphone': data['cellphone'],
      'email': data['email'],
      'imageUrl': data['imageUrl'],
    };
    contacts.add(contact);
  }
  return contacts;
}

//Update Contact
Future<void> updateContact(String uid, dynamic update) async {
  await contactsRef.doc(uid).set(update);
}

// Delete
Future<void> deleteContact(String uid) async {
  await contactsRef.doc(uid).delete().whenComplete(() => true);
}
