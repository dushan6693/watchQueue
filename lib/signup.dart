import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watch_queue/firebase/auth_service.dart';
import 'package:watch_queue/firebase/fire_store_service.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});


  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController = TextEditingController();

  _SignupState();
  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    FireStoreService firestoreService = FireStoreService();
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
                    "Sign Up",
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
                        top: 10.0, bottom: 6.0, left: 8.0, right: 8.0),
                    child: Text(
                      "Name",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 18.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _nameController,
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
                        hintText: "Sanath Perera",
                      ),
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, bottom: 6.0, left: 8.0, right: 8.0),
                    child: Text(
                      "Repeat password",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 18.0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _repeatPasswordController,
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
                  ),
                   Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("*",style: TextStyle(color: Colors.redAccent),),
                        Flexible(
                          child: Text( style: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 13.0),
                              "password must contain minimum 8 characters with numbers,a special character and one uppercase letter"),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    FilledButton(
                      onPressed:() async {
                        await authService.signUpWithEmailPassword(_emailController.text, _passwordController.text);
                        await firestoreService.register(_emailController.text,_nameController.text);
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
