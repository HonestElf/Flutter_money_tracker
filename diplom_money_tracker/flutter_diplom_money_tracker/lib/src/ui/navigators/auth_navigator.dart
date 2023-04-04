// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:flutter_diplom_money_tracker/src/business/cubit/auth_cubit.dart';
import 'package:flutter_diplom_money_tracker/src/ui/login/login_view.dart';
import 'package:flutter_diplom_money_tracker/src/ui/sign_up/sign_up_view.dart';

class AuthNavigator extends StatelessWidget {
  const AuthNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state == AuthState.login) MaterialPage(child: LoginView()),
            if (state == AuthState.signUp) MaterialPage(child: SignUpView()),
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
