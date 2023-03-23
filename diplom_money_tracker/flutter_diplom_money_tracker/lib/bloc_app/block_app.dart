import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/app_navigator.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/bloc/auth_cubit.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/bloc/auth_navigator.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/bloc/auth_repository.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/session_cubit.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/ui/login/login_view.dart';

class MyBlocApp extends StatelessWidget {
  const MyBlocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) =>
            SessionCubit(authRepo: context.read<AuthRepository>()),
        child: AppNavigator(),
      ),
    ));
  }
}
