// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:flutter_diplom_money_tracker/src/business/bloc/login/login_bloc.dart';
import 'package:flutter_diplom_money_tracker/src/business/bloc/login/login_event.dart';
import 'package:flutter_diplom_money_tracker/src/business/bloc/login/login_state.dart';
import 'package:flutter_diplom_money_tracker/src/business/cubit/auth_cubit.dart';
import 'package:flutter_diplom_money_tracker/src/data/form_submission_status.dart';
import 'package:flutter_diplom_money_tracker/src/data/repositories/auth_repository.dart';
import 'package:flutter_diplom_money_tracker/src/ui/login_body/login_body.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child: BlocProvider(
            create: (context) => LoginBloc(
              authRepo: context.read<AuthRepository>(),
              authCubit: context.read<AuthCubit>(),
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const LoginBody(),
                  const SizedBox(
                    height: 30,
                  ),
                  _loginForm(),
                  const SizedBox(
                    height: 30,
                  ),
                  _showSignUpButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginForm() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        }
      },
      listenWhen: (previous, current) {
        if (previous.formStatus != current.formStatus) {
          return true;
        }
        return false;
      },
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _usernameField(),
            _passwordField(),
            const SizedBox(
              height: 30,
            ),
            _loginButton(),
            _devLoginButton(),
          ],
        ),
      ),
    );
  }

  Widget _usernameField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) => TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
            label: Text('E-mail'), icon: Icon(Icons.person)),
        validator: (value) =>
            state.isValidUsername ? null : "Please enter a valid email address",
        onChanged: (value) => context
            .read<LoginBloc>()
            .add(LoginUsernameChanged(username: value)),
      ),
    );
  }

  Widget _passwordField() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) => TextFormField(
        keyboardType: TextInputType.visiblePassword,
        decoration: const InputDecoration(
          label: Text('Пароль'),
          icon: Icon(Icons.security),
        ),
        validator: (value) =>
            state.isValidPassword ? null : 'Password must be least 6 chars',
        onChanged: (value) => context
            .read<LoginBloc>()
            .add(LoginPasswordChanged(password: value)),
      ),
    );
  }

  Widget _loginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF9053EB),
                ),
              )
            : ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<LoginBloc>().add(LoginSubmitted());
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9053EB),
                  minimumSize: const Size(100, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text(
                  'Войти',
                  style: TextStyle(fontSize: 17),
                ),
              );
      },
    );
  }

  Widget _devLoginButton() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const Center(
                child: CircularProgressIndicator(
                  color: Color(0xFF9053EB),
                ),
              )
            : ElevatedButton(
                onPressed: () {
                  context
                      .read<LoginBloc>()
                      .add(LoginUsernameChanged(username: 'test@test.com'));
                  context
                      .read<LoginBloc>()
                      .add(LoginPasswordChanged(password: 'testtest'));
                  // if (_formKey.currentState!.validate()) {
                  context.read<LoginBloc>().add(LoginSubmitted());
                  // }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF9053EB),
                  minimumSize: const Size(100, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text(
                  'Войти DEV',
                  style: TextStyle(fontSize: 17),
                ),
              );
      },
    );
  }

  Widget _showSignUpButton(BuildContext context) {
    return SafeArea(
        child: TextButton(
      onPressed: () => context.read<AuthCubit>().showSignUp(),
      child: const Text('Don\'t have an account? Sign up.'),
    ));
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
