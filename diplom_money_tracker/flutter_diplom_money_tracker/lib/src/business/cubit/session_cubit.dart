// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:flutter_diplom_money_tracker/src/business/cubit/session_state.dart';
// import 'package:flutter_diplom_money_tracker/src/data/auth_credentials.dart';
import 'package:flutter_diplom_money_tracker/src/data/repositories/auth_repository.dart';
import 'package:module_model/module_model.dart';

class SessionCubit extends Cubit<SessionState> {
  final AuthRepository authRepo;

  User get currentUser => (state as Authenticated).user;

  SessionCubit({
    required this.authRepo,
  }) : super(UnknownSessionState()) {
    attemptAutoLogin();
  }

  void attemptAutoLogin() async {
    try {
      final user = await authRepo.getCurrentUser();

      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticated());
      }
    } on Exception catch (_) {
      emit(Unauthenticated());
    }
  }

  void showSession(AuthCredentials credentials) async {
    try {
      final user = await authRepo.getCurrentUser();
      if (user != null) {
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticated());
      }
    } on Exception catch (_) {
      emit(Unauthenticated());
    }
  }

  void signOut() {
    authRepo.signOut();
    emit(Unauthenticated());
  }
}
