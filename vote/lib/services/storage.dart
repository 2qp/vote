import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  final _fs = FirebaseStorage.instance;

  Future<String> getUrl(src) async {
    String gg = await _fs.ref().child(src + ".jpg").getDownloadURL();
    print(gg);
    return gg;
  }
}
