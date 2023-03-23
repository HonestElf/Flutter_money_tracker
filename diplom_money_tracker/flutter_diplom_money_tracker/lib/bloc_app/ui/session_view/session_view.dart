import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/session_cubit.dart';

class SessionView extends StatelessWidget {
  const SessionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Session view'),
            TextButton(
              onPressed: () => BlocProvider.of<SessionCubit>(context).signOut(),
              child: Text('Sign out'),
            )
          ],
        ),
      ),
    );
  }
}
