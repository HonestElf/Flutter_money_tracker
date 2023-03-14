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
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginForm,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'example@example.com'),
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
            decoration: const InputDecoration(hintText: 'Example'),
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
            onPressed: () async {
              if (_loginForm.currentState!.validate()) {
                try {
                  await signInWithEmailAndPassword(
                          _emailController.text, _passwordController.text)
                      .then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          duration: Duration(milliseconds: 1000),
                          backgroundColor: Colors.green,
                          content: Text('Entering...')),
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
            },
            child: const Text('Login'),
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                await signInWithEmailAndPassword('test@test.com', 'testtest')
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        duration: Duration(milliseconds: 1000),
                        backgroundColor: Colors.green,
                        content: Text('Entering...')),
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
            },
            child: const Text('DEV Login'),
          ),
        ],
      ),
    );
  }
}
