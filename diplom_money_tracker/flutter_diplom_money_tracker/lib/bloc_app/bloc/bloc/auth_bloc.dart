import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBlock extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBlock({required this.authRepository}) : super(UnAuthenticated()) {
    on<SignUpRequested>(
      (event, emit) async {
        emit(Loading());
        try {
          await authRepository.signUp(
              email: event.email, password: event.password);
        } catch (e) {
          emit(UnAuthenticated());
        }
      },
    );
  }
}
