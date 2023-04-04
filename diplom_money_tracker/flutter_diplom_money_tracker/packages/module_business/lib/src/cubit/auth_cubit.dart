// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_model/module_model.dart';

// Project imports:
import 'package:module_business/src/cubit/session_cubit.dart';

enum AuthState { login, signUp }

class AuthCubit extends Cubit<AuthState> {
  final SessionCubit sessionCubit;
  AuthCubit({required this.sessionCubit}) : super(AuthState.login);

  void showLogin() => emit(AuthState.login);
  void showSignUp() => emit(AuthState.signUp);

  void launchSession(AuthCredentials credentials) =>
      sessionCubit.showSession(credentials);
}
