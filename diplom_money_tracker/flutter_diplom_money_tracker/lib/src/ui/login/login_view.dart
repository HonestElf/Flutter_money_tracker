// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/module_business.dart';
import 'package:module_data/module_data.dart';
import 'package:module_model/module_model.dart';

// Project imports:
import 'package:flutter_diplom_money_tracker/src/ui/login_body/login_body.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

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
                  LoginForm(),
                  const SizedBox(
                    height: 30,
                  ),
                  const ShowSignUpButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  LoginForm({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
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
            const UserNameField(),
            const PasswordField(),
            const SizedBox(
              height: 30,
            ),
            LoginButton(formKey: _formKey),
            const DevLoginButton(),
          ],
        ),
      ),
    );
  }
}

class UserNameField extends StatelessWidget {
  const UserNameField({super.key});

  @override
  Widget build(BuildContext context) {
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
}

class PasswordField extends StatelessWidget {
  const PasswordField({super.key});

  @override
  Widget build(BuildContext context) {
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
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key, required this.formKey});
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
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
                  if (formKey.currentState!.validate()) {
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
}

class DevLoginButton extends StatelessWidget {
  const DevLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
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
}

class ShowSignUpButton extends StatelessWidget {
  const ShowSignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: TextButton(
      onPressed: () => context.read<AuthCubit>().showSignUp(),
      child: const Text('Don\'t have an account? Sign up.'),
    ));
  }
}
