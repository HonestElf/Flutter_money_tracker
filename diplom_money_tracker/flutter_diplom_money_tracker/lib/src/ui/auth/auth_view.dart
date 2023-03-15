import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diplom_money_tracker/src/ui/auth/logn_view.dart';
import 'package:flutter_diplom_money_tracker/src/ui/auth/signup_view.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool _isLogin = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
            child: Column(
              // mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // const Expanded(flex: 2, child: AuthViewBody()),
                // Expanded(
                //   flex: 2,
                //   child: _isLogin ? const LoginView() : const SignUpView(),
                // ),
                const AuthViewBody(),
                const SizedBox(
                  height: 70,
                ),
                _isLogin ? const LoginView() : const SignUpView(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: _isLogin
                              ? 'Еще нет аккаунта? '
                              : 'Уже есть аккаунт? ',
                          style: const TextStyle(
                              color: Colors.black, fontSize: 15)),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                        text: _isLogin ? 'Регистрация' : 'Вход',
                        style: const TextStyle(
                            color: Color(0xFF9053EB), fontSize: 15),
                      )
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthViewBody extends StatelessWidget {
  const AuthViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/loginPageImage.png',
            ),
            const Text(
              'Учет расходов',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
            const Text(
              'Ваша история расходов всегда под рукой',
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ]),
    );
  }
}
