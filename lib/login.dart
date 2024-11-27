import 'package:flutter/material.dart';
import 'package:watch_queue/firebase/auth_service.dart';
import 'package:watch_queue/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  _LoginState();
  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();

    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              bottom: 8.0, left: 8.0, right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 36.0,
                        fontWeight: FontWeight.normal),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 6.0, left: 8.0, right: 8.0),
                    child: Text(
                      "Email",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 18.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _emailController,
                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface,),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color:
                                    Theme.of(context).colorScheme.outlineVariant,
                                width: 2.0,
                                style: BorderStyle.solid)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.outline,
                                width: 2.0,
                                style: BorderStyle.solid)),
                        hintText: "yourmail@email.com",
                      ),
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 6.0, left: 8.0, right: 8.0),
                    child: Text(
                      "Password",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 18.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _passwordController,
                      style: TextStyle(color: Theme.of(context).colorScheme.onSurface,),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color:
                                    Theme.of(context).colorScheme.outlineVariant,
                                width: 2.0,
                                style: BorderStyle.solid)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.outline,
                                width: 2.0,
                                style: BorderStyle.solid)),
                        hintText: "********",
                      ),
                      obscureText: true,
                      obscuringCharacter: "*",
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  children: [
                    FilledButton(
                      onPressed: () async {
                        authService.signInWithEmailPassword(_emailController.text, _passwordController.text);
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor: Theme.of(context).colorScheme.onPrimary,
                        textStyle: const TextStyle(fontSize: 18.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        padding: const EdgeInsets.only(
                            left: 50.0, right: 50.0, top: 15.0, bottom: 15.0),
                      ),
                      child: const Text("Log in"),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                    "Don’t have an account? ",
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 15.0),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Signup()));
                      },
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurface,
                            fontSize: 15.0, fontWeight: FontWeight.w800),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
