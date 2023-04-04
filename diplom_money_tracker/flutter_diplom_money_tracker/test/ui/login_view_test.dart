import 'package:flutter/material.dart';
import 'package:flutter_diplom_money_tracker/src/ui/login/login_view.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Login view test', () {
    testWidgets('Login form extits', (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(
        home: LoginView(),
      ));

      // final fieldFinderEmail = find.text('E-mail');
      // final fieldFinderSubmit = find.text('Войти');
      final fieldFinderSubmit = find.text('Don\'t have an account? Sign up.');

      // expect(fieldFinderEmail, findsOneWidget);
      expect(fieldFinderSubmit, findsOneWidget);
    });
  });
}
