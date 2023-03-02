import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import '../auth.dart';

final FirebaseStorage storage = FirebaseStorage.instance;
final Reference ref = storage.ref();

Future<String?> uploadImage(File image) async {
  try {
    final String userFolder = Auth().currentUser!.uid;
    final String nameFile = image.path.split('/').last;
    final Reference uploadRef = ref.child(userFolder).child(nameFile);
    final UploadTask uploadTask = uploadRef.putFile(image);
    final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
    final String url = await snapshot.ref.getDownloadURL();
    if (kDebugMode) {
      print(uploadTask);
      print(url);
    }
    return url;
  } on FirebaseException catch (e) {
    return e.message;
  }
}
