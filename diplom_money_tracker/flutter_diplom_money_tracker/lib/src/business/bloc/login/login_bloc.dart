// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:flutter_diplom_money_tracker/src/business/bloc/login/login_event.dart';
import 'package:flutter_diplom_money_tracker/src/business/bloc/login/login_state.dart';
import 'package:flutter_diplom_money_tracker/src/business/cubit/auth_cubit.dart';
// import 'package:flutter_diplom_money_tracker/src/data/auth_credentials.dart';
import 'package:flutter_diplom_money_tracker/src/data/form_submission_status.dart';
import 'package:flutter_diplom_money_tracker/src/data/repositories/auth_repository.dart';
import 'package:module_model/module_model.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  LoginBloc({
    required this.authRepo,
    required this.authCubit,
  }) : super(LoginState()) {
    on<LoginEvent>(_onEvent);
  }

  Future<void> _onEvent(LoginEvent event, Emitter<LoginState> emit) async {
    //username changed
    if (event is LoginUsernameChanged) {
      emit(state.copyWith(username: event.username));
    }
    // password update
    else if (event is LoginPasswordChanged) {
      emit(state.copyWith(password: event.password));
    }
    //form submitted
    else if (event is LoginSubmitted) {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        final userId = await authRepo.login(
            username: state.username, password: state.password);
        emit(state.copyWith(formStatus: SubmissionSuccess()));

        authCubit.launchSession(
            AuthCredentials(username: state.username, userId: userId));
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e.toString())));
      }
    }
  }
}
