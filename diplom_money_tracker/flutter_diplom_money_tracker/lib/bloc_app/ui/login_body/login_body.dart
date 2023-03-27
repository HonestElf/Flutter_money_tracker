import 'package:flutter/material.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
