import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/business/bloc/profile/profile_events.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/business/bloc/profile/profile_state.dart';
import 'package:image_picker/image_picker.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ImagePicker _picker = ImagePicker();
  ProfileBloc({required User user}) : super(ProfileState(user: user)) {
    on<ProfileEvent>(_onEvent);
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

      emit(state.copyWith(avatarPath: pickedImage.path));
    } else if (event is ProvideImagePath) {
      emit(state.copyWith(avatarPath: event.avatarPath));
    } else if (event is SaveProfileChanges) {}
  }
}
