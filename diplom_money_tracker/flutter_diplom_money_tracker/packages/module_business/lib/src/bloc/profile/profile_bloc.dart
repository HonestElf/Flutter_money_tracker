// Dart imports:
import 'dart:io';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:module_data/module_data.dart';
import 'package:module_model/module_model.dart';

// Project imports:
import 'package:module_business/src/bloc/profile/profile_events.dart';
import 'package:module_business/src/bloc/profile/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ImagePicker _picker = ImagePicker();
  final StorageRepository storageRepo;

  ProfileBloc({required User user, required this.storageRepo})
      : super(ProfileState(user: user)) {
    on<ProfileEvent>(_onEvent);

    storageRepo
        .getUserAvatarUrl(user.uid)
        .then((url) => add(ProvideImagePath(avatarPath: url)));
  }

  Future<void> _onEvent(ProfileEvent event, Emitter<ProfileState> emit) async {
    if (event is ChangeAvatarRequest) {
      emit(state.copyWith(imageSourceActionSheetIsVisible: true));
    } else if (event is OpenImagePicker) {
      emit(state.copyWith(imageSourceActionSheetIsVisible: false));
      final pickedImage = await _picker.pickImage(source: event.imageSource);

      if (pickedImage == null) {
        return;
      }

      emit(state.copyWith(
          localAvatarPath: pickedImage.path, formStatus: FormSubmitting()));
    } else if (event is ProvideImagePath) {
      emit(state.copyWith(avatarPath: event.avatarPath));
    } else if (event is SaveProfileChanges) {
    } else if (event is SaveUserAvatar) {
      try {
        if (state.localAvatarPath != null) {
          await storageRepo.uploadFile(
              File(state.localAvatarPath!), state.user.uid);
          emit(state.copyWith(formStatus: SubmissionSuccess()));
          final avatarUrl = await storageRepo.getUserAvatarUrl(state.user.uid);
          add(ProvideImagePath(avatarPath: avatarUrl));
        }
      } catch (e) {
        emit(state.copyWith(
            formStatus: SubmissionFailed('Ошибка загрузки изображения')));
        rethrow;
      }
    }
  }
}
