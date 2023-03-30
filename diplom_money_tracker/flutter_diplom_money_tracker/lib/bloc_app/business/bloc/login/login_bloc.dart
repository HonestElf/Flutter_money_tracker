import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/data/auth_credentials.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/business/cubit/auth_cubit.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/data/auth_repository.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/data/form_submission_status.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/business/bloc/login/login_event.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/business/bloc/login/login_state.dart';

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
