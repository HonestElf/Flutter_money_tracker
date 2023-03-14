import 'package:flutter/material.dart';
import 'package:flutter_diplom_money_tracker/src/ui/auth/auth_view.dart';
import 'package:flutter_diplom_money_tracker/src/ui/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.userChanges(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const AuthView();
            } else {
              return const HomeView(title: 'Flutter Demo Home Page');
            }
          },
        ));
  }
}
