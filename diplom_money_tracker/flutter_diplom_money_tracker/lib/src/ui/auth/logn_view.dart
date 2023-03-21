import 'package:flutter/material.dart';
import 'package:flutter_diplom_money_tracker/src/business/auth/firebase_auth_service.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _loginForm = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'E-mail'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email is required';
              }
              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                return "Please enter a valid email address";
              }

              return null;
            },
          ),
          TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            decoration: const InputDecoration(
                hintText: 'Пароль', alignLabelWithHint: true),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }

              return null;
            },
          ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9053EB),
              minimumSize: const Size(100, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
            onPressed: _isLoading
                ? null
                : () async {
                    setState(() {
                      _isLoading = true;
                    });
                    if (_loginForm.currentState!.validate()) {
                      try {
                        await signInWithEmailAndPassword(
                                _emailController.text, _passwordController.text)
                            .then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                duration: Duration(milliseconds: 1000),
                                backgroundColor: Colors.green,
                                content: Text('Выполняется вход...')),
                          );
                        });
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                              duration: const Duration(milliseconds: 1000),
                              backgroundColor: Colors.red,
                              content: Text(error.toString())),
                        );
                      }
                    }
                    setState(() {
                      _isLoading = false;
                    });
                  },
            child: _isLoading
                ? const CircularProgressIndicator(
                    color: Color(0xFF9053EB),
                  )
                : const Text(
                    'Войти',
                    style: TextStyle(fontSize: 17),
                  ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9053EB),
              minimumSize: const Size(100, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
            onPressed: _isLoading
                ? null
                : () async {
                    setState(() {
                      _isLoading = true;
                    });
                    try {
                      await signInWithEmailAndPassword(
                              'test@test.com', 'testtest')
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              duration: Duration(milliseconds: 1000),
                              backgroundColor: Colors.green,
                              content: Text('Выполняется вход...')),
                        );
                      });
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            duration: const Duration(milliseconds: 1000),
                            backgroundColor: Colors.red,
                            content: Text(error.toString())),
                      );
                    }
                    setState(() {
                      _isLoading = false;
                    });
                  },
            child: _isLoading
                ? const CircularProgressIndicator(
                    color: Color(0xFF9053EB),
                  )
                : const Text(
                    'DEV Войти',
                    style: TextStyle(fontSize: 17),
                  ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF9053EB),
              minimumSize: const Size(100, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
            ),
            onPressed: _isLoading
                ? null
                : () async {
                    setState(() {
                      _isLoading = true;
                    });
                    try {
                      await signInWithEmailAndPassword(
                              'test2@test.com', 'testtest2')
                          .then((value) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              duration: Duration(milliseconds: 1000),
                              backgroundColor: Colors.green,
                              content: Text('Выполняется вход...')),
                        );
                      });
                    } catch (error) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            duration: const Duration(milliseconds: 1000),
                            backgroundColor: Colors.red,
                            content: Text(error.toString())),
                      );
                    }
                    setState(() {
                      _isLoading = false;
                    });
                  },
            child: _isLoading
                ? const CircularProgressIndicator(
                    color: Color(0xFF9053EB),
                  )
                : const Text(
                    'DEV 2 Войти',
                    style: TextStyle(fontSize: 17),
                  ),
          ),
        ],
      ),
    );
  }
}
