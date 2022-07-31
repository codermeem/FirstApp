import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../widget/widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _globalKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    //dispose holo ak page theke onno page jabar sathe sathe sob clear
    //cache remover
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0),
        child: Form(
          // globalkey use kora hoy validation er jonno.
          // from er kono filed faka rekhe sign in ba up kora jabe na
          key: _globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //logo
              logo(),
              const SizedBox(
                height: 30,
              ),
              //full name
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Full Name",
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    enabledBorder: InputBorder.none,
                  ),
                  validator: (val) => val!.isEmpty ? "Empty field" : null,
                ),
              ),

              //email
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: "Email",
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  enabledBorder: InputBorder.none,
                ),
                validator: (val) => val!.isEmpty ? "Empty field" : null,
              ),

              //password
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    filled: true,
                    fillColor: Colors.grey.shade200,
                    enabledBorder: InputBorder.none,
                  ),
                  validator: (val) => val!.isEmpty ? "Empty field" : null,
                ),
              ),

              //btn
              ElevatedButton(
                onPressed: () async {
                  if (_globalKey.currentState!.validate()) {
                    //try
                    try {
                      final credential = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );
                      var user = credential.user;
                      if (user != null) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                            (Route) => false);
                      }
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');

                        //snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("The password provided is too weak."),
                          ),
                        );
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');

                        //snakebar
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "This account already exists for this email"),
                          ),
                        );
                      }
                    } catch (e) {
                      print(e);
                    }
                  }
                },
                // style
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.lightBlue.shade500),
                ),
                child: const Text(
                  "Sign-up",
                ),
              ),

              const SizedBox(
                height: 30.0,
              ),

              //got to sign up page
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil("/sign-in/", (route) => false);
                },
                child: const Text("Already registered? Login here!"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
