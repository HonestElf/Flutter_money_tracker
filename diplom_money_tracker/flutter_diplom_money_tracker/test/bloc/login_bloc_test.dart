import 'package:flutter_test/flutter_test.dart';
import 'package:module_business/module_business.dart';
import 'package:module_data/module_data.dart';
import 'package:module_model/module_model.dart';

import 'package:bloc_test/bloc_test.dart';

void main() {
  group('Login bloc test', () {
    late LoginBloc loginBloc;

    setUp(() {
      loginBloc = LoginBloc(
          authRepo: AuthRepository(),
          authCubit: AuthCubit(
              sessionCubit: SessionCubit(authRepo: AuthRepository())));
    });

    test('Initial name test', () => {expect(loginBloc.state.username, '')});
    test('Initial password test', () => {expect(loginBloc.state.password, '')});
    test('Initial status test',
        () => {expect(loginBloc.state.formStatus, const InitialFormStatus())});

    blocTest<LoginBloc, LoginState>(
      'emit LoginUsernameChanged(testName)',
      build: () => loginBloc,
      act: (bloc) => bloc.add(
        LoginUsernameChanged(username: 'testName'),
      ),
      expect: () => [
        isA<LoginState>().having((p0) => p0.username, 'username', 'testName')
      ],
    );
  });
}
