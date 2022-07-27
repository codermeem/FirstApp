import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_exam/firebase_options.dart';
import 'package:flutter/material.dart';


class Reglogin extends StatefulWidget {
  const Reglogin({Key? key}) : super(key: key);

  @override
  State<Reglogin> createState() => _RegloginState();
}

class _RegloginState extends State<Reglogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user?.emailVerified ?? false) {
                print("You're a verified user");
              } else {
                print("You need to verify your email first");
              }
              return const Text("Done");
            default:
              return const Text("Loading");
          }
        },
      ),
    );
  }
}
