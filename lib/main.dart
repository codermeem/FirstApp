//linked with firebase
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_exam/pages/signin.dart';
import 'package:first_exam/pages/signup.dart';
import 'firebase_options.dart';
//flutter package
import 'package:flutter/material.dart';

Future<void> main() async {
  //app run hobaro age flutter binding ensure korbe je app er sob thik ase ki na.
  WidgetsFlutterBinding.ensureInitialized();

  //firebase kon kon platform a run hobe seta initialize korbe
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: const HomePage(),
      routes: {
        "/sign-in/": (context) => const SignIn(),
        "/sign-up/": (context) => const SignUp(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
           case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
            // if (user?.emailVerified ?? false) {
            //   return const Text("Done");
            // } else {
            //   return const VerifyEmailView();
            // }
            return const SignIn();
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
