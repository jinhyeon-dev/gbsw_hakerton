import 'package:flutter/material.dart';
import 'package:gbsw_hakerton/main.dart';
import 'package:gbsw_hakerton/widgets/signin_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignSearch extends StatelessWidget {
  const SignSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.userChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return const MyAppScreen();
          } else {
            return  SignInWidget();
          }
        },
      ),
    );
  }
}
