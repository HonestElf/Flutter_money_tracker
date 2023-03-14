import 'package:flutter/material.dart';
import 'package:flutter_diplom_money_tracker/src/ui/auth/logn_view.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    return const LoginView();
  }
}
