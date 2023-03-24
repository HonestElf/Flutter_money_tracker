import 'package:firebase_auth/firebase_auth.dart';

class DataRepository {
  Future<User?> getCurrentUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      return user;
    } catch (e) {
      rethrow;
    }
  }
}
