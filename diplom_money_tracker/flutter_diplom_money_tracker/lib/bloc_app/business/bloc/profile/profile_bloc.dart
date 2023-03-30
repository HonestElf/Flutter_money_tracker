import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/business/bloc/profile/profile_events.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/business/bloc/profile/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required User user}) : super(ProfileState(user: user));

  Future<void> _onEvent(ProfileEvent event, Emitter<ProfileState> emit) async {
    if (event is ChangeAvatarRequest) {
    } else if (event is OpenImagePicker) {
    } else if (event is ProvideImagePath) {
      emit(state.copyWith(avatarPath: event.avatarPath));
    } else if (event is SaveProfileChanges) {}
  }
}
