import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  Future<User?> getCurrentUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;

      return user;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> _getuserId() async {
    try {
      final userId = FirebaseAuth.instance.currentUser?.uid;

      return userId;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> attemptAutoLogin() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;

      return currentUser != null ? _getuserId() : null;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> login(
      {required String username, required String password}) async {
    try {
      final result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: username, password: password);

      return result.user != null ? _getuserId() : null;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> signUp(
      {required String username, required String password}) async {
    try {
      final result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: username, password: password);

      return result.user != null;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
