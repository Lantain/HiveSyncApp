import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:hive_sync_app/views/hives.dart';

import '../data/auth.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final auth = Auth();

  @override
  Widget build(BuildContext context) {
    if (auth.currentUser != null) {
      return const HivesPage();
    }
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: Center(
          child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Sign in to Hive Exbeerience",
                style: TextStyle(fontSize: 32),
                textAlign: TextAlign.center,
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: SignInButton(Buttons.Google, onPressed: () async {
                    await auth.signInWithGoogle();
                    if (auth.currentUser != null) {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const HivesPage(),
                      ));
                    }
                  }))
            ]),
      )),
    );
  }
}
