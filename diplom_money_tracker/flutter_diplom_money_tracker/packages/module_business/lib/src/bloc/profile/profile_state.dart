// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:module_model/module_model.dart';

class ProfileState {
  final User user;
  final String? localAvatarPath;
  final String? avatarPath;

  final FormSubmissionStatus formStatus;

  bool imageSourceActionSheetIsVisible;

  String get email => user.email ?? '';

  ProfileState({
    required this.user,
    this.avatarPath,
    this.localAvatarPath,
    this.formStatus = const InitialFormStatus(),
    this.imageSourceActionSheetIsVisible = false,
  });

  ProfileState copyWith({
    User? user,
    String? avatarPath,
    String? localAvatarPath,
    FormSubmissionStatus? formStatus,
    bool? imageSourceActionSheetIsVisible,
  }) {
    return ProfileState(
      user: user ?? this.user,
      avatarPath: avatarPath ?? this.avatarPath,
      localAvatarPath: localAvatarPath ?? this.localAvatarPath,
      formStatus: formStatus ?? this.formStatus,
      imageSourceActionSheetIsVisible: imageSourceActionSheetIsVisible ??
          this.imageSourceActionSheetIsVisible,
    );
  }
}
