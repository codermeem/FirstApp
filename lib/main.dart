//linked with firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
//flutter package
import 'package:flutter/material.dart';

Future<void> main() async {
  //app run hobaro age flutterbinding ensure korbe je app er sob thik ase ki na.
  WidgetsFlutterBinding.ensureInitialized();

  //firebase kon kon platform a run hobe seta initialzize korbe
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: EmailVerify(),
    );
  }
}

class EmailVerify extends StatefulWidget {
  const EmailVerify({Key? key}) : super(key: key);

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
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
                return const Text("Done");
              } else {
                return const VerifyEmailView();
              }
            default:
              return const Text("Loading");
          }
        },
      ),
    );
  }
}

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Please verify your email address"),
        ElevatedButton(
          onPressed: () async {
            final user = FirebaseAuth.instance.currentUser;
            await user!.sendEmailVerification();
            if (user != null) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => VerifyEmailView()),
                  (Route) => false);
            }
          },
          child: const Text("Send email verification"),
        ),
      ],
    );
  }
}
