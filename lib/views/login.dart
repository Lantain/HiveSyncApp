import 'package:flutter/material.dart';
import 'package:hive_sync_app/views/hives.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const HivesPage()));
                      },
                      child: const Text("login")))
            ]),
      )),
    );
  }
}
