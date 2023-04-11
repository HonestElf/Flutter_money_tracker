// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/module_business.dart';

// Project imports:
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
            if (state == AuthState.login)
              const MaterialPage(child: LoginView()),
            if (state == AuthState.signUp)
              const MaterialPage(child: SignUpView()),
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
