import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

final storage = FirebaseStorage.instance;
final rootRef = storage.ref();

Reference userRef = rootRef.child('users');
Reference medicinesRef({required String userID}) => userRef.child(userID).child('medicines');

Future<String> uploadImage(Reference ref, Uint8List bytes) async {
  final uuid = const Uuid().v4();
  final fileRef = ref.child(uuid);
  final uploadTask = fileRef.putData(bytes);
  final snapshot = await uploadTask.whenComplete(() => null);
  final url = await snapshot.ref.getDownloadURL();
  return url;
}
