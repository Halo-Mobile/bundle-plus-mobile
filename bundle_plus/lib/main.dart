import 'package:bundle_plus/screens/detailscreen.dart';
import 'package:bundle_plus/screens/home.dart';
import 'package:bundle_plus/screens/listproduct.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:one_context/one_context.dart';

import '../screens/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bundle_plus/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: OneContext().builder,
      title: 'Login',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return LoginScreen();
          }
        },
      ),
    );
  }
}
