import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/bloc/auth_cubit.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/bloc/auth_navigator.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/session_cubit.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/session_state.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/ui/loading_view/loading_view.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/ui/session_view/session_view.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            if (state is UnknownSessionState)
              MaterialPage(child: LoadingView()),
            if (state is Unauthenticated)
              MaterialPage(
                child: BlocProvider(
                  create: (context) =>
                      AuthCubit(sessionCubit: context.read<SessionCubit>()),
                  child: AuthNavigator(),
                ),
              ),
            if (state is Authenticated) MaterialPage(child: SessionView())
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
