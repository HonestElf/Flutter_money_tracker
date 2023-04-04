// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:flutter_diplom_money_tracker/src/business/cubit/session_cubit.dart';
// import 'package:flutter_diplom_money_tracker/src/data/repositories/auth_repository.dart';
// import 'package:flutter_diplom_money_tracker/src/data/repositories/storage_repository.dart';
import 'package:flutter_diplom_money_tracker/src/ui/navigators/app_navigator.dart';
import 'package:module_data/module_data.dart';

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
            create: (context) => StorageRepository(),
          ),
        ],
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
