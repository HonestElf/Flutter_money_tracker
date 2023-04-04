// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:flutter_diplom_money_tracker/src/business/bloc/sign_up/sign_up_event.dart';
import 'package:flutter_diplom_money_tracker/src/business/bloc/sign_up/sign_up_state.dart';
import 'package:flutter_diplom_money_tracker/src/business/cubit/auth_cubit.dart';
import 'package:flutter_diplom_money_tracker/src/data/form_submission_status.dart';
import 'package:flutter_diplom_money_tracker/src/data/repositories/auth_repository.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepository authRepo;
  final AuthCubit authCubit;

  SignUpBloc({
    required this.authRepo,
    required this.authCubit,
  }) : super(SignUpState()) {
    on<SignUpEvent>(_onEvent);
  }

  Future<void> _onEvent(SignUpEvent event, Emitter<SignUpState> emit) async {
    //username changed
    if (event is SignUpUsernameChanged) {
      emit(state.copyWith(username: event.username));
    }
    // password update
    else if (event is SignUpPasswordChanged) {
      emit(state.copyWith(password: event.password));
    }
    //form submitted
    else if (event is SignUpSubmitted) {
      emit(state.copyWith(formStatus: FormSubmitting()));

      try {
        await authRepo.signUp(
            username: state.username, password: state.password);
        emit(state.copyWith(formStatus: SubmissionSuccess()));
      } catch (e) {
        emit(state.copyWith(formStatus: SubmissionFailed(e.toString())));
      }
    }
  }
}
