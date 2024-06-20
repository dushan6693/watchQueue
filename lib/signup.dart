import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  final String title;
  const Signup({super.key, required this.title});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  _SignupState();
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
              top: 20.0, bottom: 8.0, left: 8.0, right: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "Sign Up",
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
                      "Name",
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
                        hintText: "Sanath Perera",
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
                        hintText: "sanathp99@email.com",
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
                      "Create a password",
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 6.0, left: 8.0, right: 8.0),
                    child: Text(
                      "Repeat password",
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
                      child: const Text("Sign up"),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
