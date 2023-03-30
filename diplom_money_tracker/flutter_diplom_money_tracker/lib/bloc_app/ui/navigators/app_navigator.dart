import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/business/cubit/auth_cubit.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/ui/navigators/auth_navigator.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/business/cubit/session_cubit.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/data/session_state.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/ui/view_router/view_router.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/ui/loading_view/loading_view.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionCubit, SessionState>(
      builder: (context, state) {
        return Navigator(
          pages: [
            //show loading screen
            if (state is UnknownSessionState)
              const MaterialPage(child: LoadingView()),

            //show auth flow
            if (state is Unauthenticated)
              MaterialPage(
                child: BlocProvider(
                  create: (context) =>
                      AuthCubit(sessionCubit: context.read<SessionCubit>()),
                  child: const AuthNavigator(),
                ),
              ),

            //show session
            if (state is Authenticated) const MaterialPage(child: ViewRouter())
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
