import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/app_navigator.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/bloc/auth_repository.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/bloc/data_repository.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/session_cubit.dart';

class MyBlocApp extends StatelessWidget {
  const MyBlocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => DataRepository(),
        )
      ],
      child: BlocProvider(
        create: (context) => SessionCubit(
            authRepo: context.read<AuthRepository>(),
            dataRepo: context.read<DataRepository>()),
        child: const AppNavigator(),
      ),
    ));
  }
}
