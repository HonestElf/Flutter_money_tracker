import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/bloc/auth_cubit.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/bloc/auth_repository.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/bloc/form_submission_status.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/bloc/sign_up/sign_up_bloc.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/bloc/sign_up/sign_up_event.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/bloc/sign_up/sign_up_state.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: BlocProvider(
            create: (context) => SignUpBloc(
                  authRepo: context.read<AuthRepository>(),
                  authCubit: context.read<AuthCubit>(),
                ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                _signUpForm(),
                _showLoginButton(context),
              ],
            )),
      ),
    );
  }

  Widget _signUpForm() {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        final formStatus = state.formStatus;
        if (formStatus is SubmissionFailed) {
          _showSnackBar(context, formStatus.exception.toString());
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _usernameField(),
            _passwordField(),
            _signUpButton(),
          ],
        ),
      ),
    );
  }

  Widget _usernameField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) => TextFormField(
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
            label: Text('E-mail'), icon: Icon(Icons.person)),
        validator: (value) =>
            state.isValidUsername ? null : "Please enter a valid email address",
        onChanged: (value) => context
            .read<SignUpBloc>()
            .add(SignUpUsernameChanged(username: value)),
      ),
    );
  }

  Widget _passwordField() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) => TextFormField(
        keyboardType: TextInputType.visiblePassword,
        decoration: const InputDecoration(
          label: Text('Пароль'),
          icon: Icon(Icons.security),
        ),
        validator: (value) =>
            state.isValidPassword ? null : 'Password must be least 6 chars',
        onChanged: (value) => context
            .read<SignUpBloc>()
            .add(SignUpPasswordChanged(password: value)),
      ),
    );
  }

  Widget _signUpButton() {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return state.formStatus is FormSubmitting
            ? const CircularProgressIndicator(
                color: Color(0xFF9053EB),
              )
            : ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<SignUpBloc>().add(SignUpSubmitted());
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

  Widget _showLoginButton(BuildContext context) {
    return SafeArea(
        child: TextButton(
      onPressed: () => context.read<AuthCubit>().showLogin(),
      child: Text('Already have an account? Sign in.'),
    ));
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
