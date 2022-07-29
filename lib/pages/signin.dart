import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_exam/pages/product_grid.dart';
import 'package:flutter/material.dart';
import '../widget/widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _globalKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Form(
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              logo(),
              const SizedBox(
                height: 30,
              ),

              //Email
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  enabledBorder: InputBorder.none,
                ),
                validator: (val) => val!.isEmpty ? "empty fill" : null,
              ),

              //password
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0, top: 10),
                //password
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    enabledBorder: InputBorder.none,
                  ),
                  validator: (val) => val!.isEmpty ? "empty fill" : null,
                ),
              ),

              //sign in btn
              ElevatedButton(
                onPressed: () async {
                  if (_globalKey.currentState!.validate()) {
                    try {
                      //firebase auth porjonto ready hoye thable firebase auth instance er jonno
                      final credential = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );
                      var user = credential.user;
                      if (user != null) {
                        Navigator.pushAndRemoveUntil<void>(
                            context,
                            MaterialPageRoute<void>(
                                builder: (context) => ProductGridPage()),
                            (route) => false);
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("No user found for that email."),
                          ),
                        );
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text("Wrong password provided for that user."),
                          ),
                        );
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.lightBlue.shade500)),
                child: const Text("Sign-in"),
              ),

              const SizedBox(
                height: 30.0,
              ),

              //got to sign up page
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/sign-up/", (route) => false);
                },
                child: const Text("Not registered yet? Register here!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
