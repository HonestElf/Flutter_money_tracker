import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/data/auth_credentials.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/data/auth_repository.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/data/data_repository.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/data/session_state.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository authRepo;
  final DataRepository dataRepo;

  SessionCubit({required this.authRepo, required this.dataRepo})
      : super(UnknownSessionState()) {
    attemptAutoLogin();
  }

  void attemptAutoLogin() async {
    try {
      final user = await dataRepo.getCurrentUser();

      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticated());
      }
    } on Exception catch (e) {
      emit(Unauthenticated());
    }
  }

  // void showAuth() => emit(Unauthenticated());
  void showSession(AuthCredentials credentials) async {
    try {
      final user = await dataRepo.getCurrentUser();
      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticated());
      }
    } on Exception catch (e) {
      emit(Unauthenticated());
    }
  }

  void signOut() {
    authRepo.signOut();
    emit(Unauthenticated());
  }
}
