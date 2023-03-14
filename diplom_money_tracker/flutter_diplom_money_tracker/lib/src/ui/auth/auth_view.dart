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
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
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
              _isLogin ? const LoginView() : const SignUpView(),
              Align(
                alignment: Alignment.bottomCenter,
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: _isLogin
                            ? 'Еще нет аккаунта? '
                            : 'Уже есть аккаунт? ',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 15)),
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
              )
            ],
          )),
    );
  }
}
