import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageRepository {
  Future<void> uploadFile(File file, String userId) async {
    try {
      final imgRef =
          FirebaseStorage.instance.ref().child('avatars/${userId}_avatar');

      imgRef.putFile(file);
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getUserAvatarUrl(String userId) async {
    try {
      final imageUrl = await FirebaseStorage.instance
          .ref('avatars/${userId}_avatar')
          .getDownloadURL();
      return imageUrl;
    } catch (e) {
      rethrow;
    }
  }
}
