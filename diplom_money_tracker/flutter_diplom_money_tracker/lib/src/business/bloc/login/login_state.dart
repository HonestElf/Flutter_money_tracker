// Project imports:
import 'package:flutter_diplom_money_tracker/src/data/form_submission_status.dart';

class LoginState {
  final String username;
  // bool get isValidUsername =>
  //     !RegExp(r'\S+@\S+\.\S+').hasMatch(username) && username.length > 3;
  bool get isValidUsername => username.length > 3;

  final String password;
  bool get isValidPassword => password.length > 5;

  final FormSubmissionStatus formStatus;

  LoginState({
    this.password = '',
    this.username = '',
    this.formStatus = const InitialFormStatus(),
  });

  LoginState copyWith(
      {String? username, String? password, FormSubmissionStatus? formStatus}) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      formStatus: formStatus ?? this.formStatus,
    );
  }
}
