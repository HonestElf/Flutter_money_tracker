import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

//registration method
  Future<void> signUp({required String email, required String password}) async {
    try {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        throw Exception('Password is too weak');
      } else if (error.code == 'email-already-in-use') {
        throw Exception('This account already exists');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
