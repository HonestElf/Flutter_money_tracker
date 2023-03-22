import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_diplom_money_tracker/bloc_app/block_app.dart';
import 'package:flutter_diplom_money_tracker/firebase_options.dart';
import 'package:flutter_diplom_money_tracker/src/ui/app.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // runApp(const MyApp());
  runApp(const MyBlocApp());
}
