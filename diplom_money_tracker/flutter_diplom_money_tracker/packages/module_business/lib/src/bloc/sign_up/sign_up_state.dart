// Package imports:
import 'package:module_model/module_model.dart';

class SignUpState {
  final String username;
  // bool get isValidUsername =>
  //     !RegExp(r'\S+@\S+\.\S+').hasMatch(username) && username.length > 3;
  bool get isValidUsername => username.length > 3;

  final String password;
  bool get isValidPassword => password.length > 5;

  final FormSubmissionStatus formStatus;

  SignUpState({
    this.password = '',
    this.username = '',
    this.formStatus = const InitialFormStatus(),
  });

  SignUpState copyWith(
      {String? username, String? password, FormSubmissionStatus? formStatus}) {
    return SignUpState(
      username: username ?? this.username,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
