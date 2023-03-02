import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

final FirebaseStorage storage = FirebaseStorage.instance;
final Reference ref = storage.ref();

Future<String> uploadImage(File image) async {
/*   final String userFolder = Auth().currentUser!.uid;
  final String nameFile = image.path.split('/').last;
  final Reference uploadRef = ref.child(userFolder).child(nameFile);
  final UploadTask uploadTask = uploadRef.putFile(image);
  final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
  final String url = await snapshot.ref.getDownloadURL(); */
  Directory appDocDir = await getApplicationDocumentsDirectory();
  String filePath = '${appDocDir.absolute}/file-to-upload.png';
  final Reference uploadRef = ref.child('user').child('el nombre');
  final UploadTask uploadTask = uploadRef.putFile(image);
  final TaskSnapshot snapshot = await uploadTask.whenComplete(() => true);
  if (kDebugMode) {
    print(uploadTask);
  }

  return '';
}
