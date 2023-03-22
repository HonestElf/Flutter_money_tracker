import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/bloc/bloc/auth_bloc.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/data/repositories/auth_repository.dart';

class MyBlocApp extends StatelessWidget {
  const MyBlocApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider(
        create: (context) => AuthBlock(
            authRepository: RepositoryProvider.of<AuthRepository>(context)),
        child: MaterialApp(
          title: 'Flutter bloc demo',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: Container(
            child: Text('asads'),
          ),
        ),
      ),
    );
  }
}
