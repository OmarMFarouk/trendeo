import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trendeo/core/shared.dart';
import 'package:trendeo/firebase_options.dart';
import 'package:trendeo/src/root_app.dart';

// true = lighet mood
// folse = dark mood
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const RootApp());
}
