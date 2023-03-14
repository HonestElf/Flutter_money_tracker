import 'package:firebase_auth/firebase_auth.dart';

String _determineError(FirebaseAuthException exception) {
  switch (exception.code) {
    case 'weak-password':
      return 'The password provided is too weak.';
    case 'email-already-in-use':
      return 'The account already exists for that email.';
    case 'user-not-found':
      return 'No user found for that email.';
    case 'wrong-password':
      return 'Wrong password provided for that user.';
    default:
      return 'Unknown error';
  }
}

Future<void> createUserWithEmailAndPassword(
    String emailAddress, String password) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress, password: password);
  } on FirebaseAuthException catch (error) {
    throw _determineError(error);
  } catch (e) {
    throw e.toString();
  }
}

Future<void> signInWithEmailAndPassword(
    String emailAddress, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: emailAddress, password: password);
  } on FirebaseAuthException catch (error) {
    throw _determineError(error);
  } catch (e) {
    throw e.toString();
  }
}

void firebaseLogout() async {
  await FirebaseAuth.instance.signOut();
}
