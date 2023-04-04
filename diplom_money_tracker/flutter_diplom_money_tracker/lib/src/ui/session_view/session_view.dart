// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:flutter_diplom_money_tracker/src/business/cubit/session_cubit.dart';

class SessionView extends StatelessWidget {
  const SessionView({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello $username'),
            TextButton(
              onPressed: () => BlocProvider.of<SessionCubit>(context).signOut(),
              child: const Text('Sign out'),
            )
          ],
        ),
      ),
    );
  }
}
