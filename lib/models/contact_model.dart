import 'package:cloud_firestore/cloud_firestore.dart';

class ContactModel {
  final String userUid;
  final String name;
  final String email;
  final String imageUrl;

  ContactModel({
    required this.userUid,
    required this.name,
    required this.email,
    required this.imageUrl,
  });

  static ContactModel fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return ContactModel(
      userUid: snapshot.id,
      name: data['name'],
      email: data['email'],
      imageUrl: data['imageUrl'],
    );
  }
}
