import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_diplom_money_tracker/src/ui/login/login_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:module_business/module_business.dart';
import 'package:module_data/module_data.dart';

void main() {
  group('Login view test', () {
    testWidgets('Login form extits', (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: RepositoryProvider(
            create: (context) => AuthRepository(),
            child: BlocProvider(
              create: (context) => SessionCubit(
                authRepo: context.read<AuthRepository>(),
              ),
              child: BlocProvider(
                create: (context) => AuthCubit(
                  sessionCubit: context.read<SessionCubit>(),
                ),
                child: const LoginView(),
              ),
            )),
      ));

      final fieldFinderSubmit = find.text('Don\'t have an account? Sign up.');

      expect(fieldFinderSubmit, findsOneWidget);
    });
  });
}
