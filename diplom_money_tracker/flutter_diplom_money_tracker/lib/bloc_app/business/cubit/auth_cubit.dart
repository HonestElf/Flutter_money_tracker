import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/data/auth_credentials.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/business/cubit/session_cubit.dart';

enum AuthState { login, signUp }

class AuthCubit extends Cubit<AuthState> {
  final SessionCubit sessionCubit;
  AuthCubit({required this.sessionCubit}) : super(AuthState.login);

  void showLogin() => emit(AuthState.login);
  void showSignUp() => emit(AuthState.signUp);

  void launchSession(AuthCredentials credentials) =>
      sessionCubit.showSession(credentials);
}
