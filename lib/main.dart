//linked with firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
//flutter package
import 'package:flutter/material.dart';
//pages
import 'pages/homepage.dart';


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
      home: HomePage(),
    );
  }
}
