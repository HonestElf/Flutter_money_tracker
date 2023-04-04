// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:module_business/module_business.dart';
import 'package:module_data/module_data.dart';

// Project imports:
import 'package:flutter_diplom_money_tracker/src/ui/navigators/app_navigator.dart';

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
