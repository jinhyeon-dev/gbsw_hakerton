import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gbsw_hakerton/screens/main_screen/main_screen.dart';
import 'package:gbsw_hakerton/widgets/signin_widget.dart';

class SignCheack extends StatelessWidget {
  const SignCheack({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            StreamBuilder<User?>(
              stream: FirebaseAuth.instance.userChanges(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return const MainScreen();
                } else {
                 return SignInWidget();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
