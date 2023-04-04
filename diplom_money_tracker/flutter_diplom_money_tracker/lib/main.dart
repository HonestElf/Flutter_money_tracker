// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';

// Project imports:
import 'package:flutter_diplom_money_tracker/firebase_options.dart';
import 'package:flutter_diplom_money_tracker/src/block_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyBlocApp());
}
