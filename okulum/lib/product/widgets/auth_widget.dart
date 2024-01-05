import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../feature/home/view/home_screen.dart';
import '../../feature/auth/screens/login_screen.dart';
import '../../feature/schools/view/school_view.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key, required this.snapShot}) : super(key: key);
  final AsyncSnapshot<User?> snapShot;

  @override
  Widget build(BuildContext context) {
    if (snapShot.connectionState == ConnectionState.active) {
      return snapShot.hasData ? SchoolScreen() : LoginScreen();
    }
    return const Scaffold(
      body: Center(
        child: Placeholder(),
      ),
    );

    // final firebaseUser = context.watch<User?>();
    //
    // if (firebaseUser != null) {
    //   return const HomeScreen();
    // }
    // return const LoginScreen();
  }
}
