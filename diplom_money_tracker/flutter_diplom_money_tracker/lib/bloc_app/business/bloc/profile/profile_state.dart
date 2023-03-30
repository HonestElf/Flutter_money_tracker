import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/data/form_submission_status.dart';

class ProfileState {
  final User user;
  final String? avatarPath;

  String get email => user.email ?? '';

  final FormSubmissionStatus formStatus;

  ProfileState(
      {required this.user,
      this.avatarPath,
      this.formStatus = const InitialFormStatus()});

  ProfileState copyWith(
      {User? user, String? avatarPath, FormSubmissionStatus? formStatus}) {
    return ProfileState(
        user: user ?? this.user,
        avatarPath: avatarPath ?? this.avatarPath,
        formStatus: formStatus ?? this.formStatus);
  }
}
