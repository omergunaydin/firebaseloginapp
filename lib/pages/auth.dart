import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseloginapp/pages/home.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // user logged in
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return LoginPage();
          }

          // user is not logged in
        },
      ),
    );
  }
}
