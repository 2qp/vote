import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  Future<void> upload(name, fileBytes) async {
    await FirebaseStorage.instance.ref(name + ".jpg").putData(fileBytes!);
  }
}
