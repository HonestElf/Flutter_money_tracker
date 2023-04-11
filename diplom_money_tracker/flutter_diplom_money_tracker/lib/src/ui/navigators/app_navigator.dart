// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/module_business.dart';
import 'package:module_data/module_data.dart';
import 'package:module_model/module_model.dart';

// Project imports:
import 'package:flutter_diplom_money_tracker/src/ui/loading_view/loading_view.dart';
import 'package:flutter_diplom_money_tracker/src/ui/navigators/auth_navigator.dart';
import 'package:flutter_diplom_money_tracker/src/ui/view_router/view_router.dart';

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
            if (state is Authenticated)
              MaterialPage(
                child: RepositoryProvider(
                  create: (context) => DatabaseRepository(
                      userId: context.read<SessionCubit>().currentUser.uid),
                  child: BlocProvider(
                    create: (context) => CostsBloc(
                      dataRepo: context.read<DatabaseRepository>(),
                    ),
                    child: const ViewRouter(),
                  ),
                ),
              ),
          ],
          onPopPage: (route, result) => route.didPop(result),
        );
      },
    );
  }
}
