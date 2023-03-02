import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference refUsers = firestore.collection('users');

Stream<List> getAllUsersStream() {
  return refUsers.snapshots().map((querySnapshot) {
    return querySnapshot.docs.map((document) => document.data()).toList();
  });
}

// Read
Future<List> getAllUsers() async {
  QuerySnapshot querySnapshot = await refUsers.get();
  List<DocumentSnapshot> documents = querySnapshot.docs;
  return documents.map((documentSnapshot) => documentSnapshot.data()).toList();
}

// Create
Future<void> addUser(String name) async {
  await firestore.collection('users').add({'name': name});
}

// Update
Future<void> updateUser(String uid, String newName) async {
  await firestore.collection('users').doc(uid).set({'name': newName});
}

// Delete
Future<void> deleteUser(String uid, String newName) async {
  await firestore.collection('users').doc(uid).set({'name': newName});
}
