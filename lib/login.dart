import 'package:flutter/material.dart';
import 'package:watch_queue/signup.dart';

class Login extends StatefulWidget {
  final String title;
  const Login({super.key, required this.title});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  _LoginState();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        elevation: 5.0,
        shadowColor: Colors.black12,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 40.0, bottom: 8.0, left: 8.0, right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
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
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 18.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
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
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 18.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
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
                      onPressed: () {},
                      style: FilledButton.styleFrom(
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
                  const Text(
                    "Don’t have an account? ",
                    style: TextStyle(fontSize: 15.0),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>const Signup(title: 'WatchQueue')));
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
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
