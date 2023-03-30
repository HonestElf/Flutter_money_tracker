import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/ui/navigators/app_navigator.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/data/repositories/auth_repository.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/business/cubit/session_cubit.dart';

class MyBlocApp extends StatelessWidget {
  const MyBlocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RepositoryProvider(
        create: (context) => AuthRepository(),
        child: BlocProvider(
          create: (context) => SessionCubit(
            authRepo: context.read<AuthRepository>(),
          ),
          child: const AppNavigator(),
        ),
      ),
    );
  }
}
