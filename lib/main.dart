import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:watch_queue/home.dart';
import 'package:watch_queue/res/color_profile.dart';
import 'package:watch_queue/res/items/item_wishlist.dart';
import 'package:watch_queue/signup.dart';
import 'package:watch_queue/view_post.dart';

import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'watch queue Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          useMaterial3: true,
          colorScheme: ColorProfile.light),
      darkTheme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          useMaterial3: true,
          colorScheme: ColorProfile.dark),
      themeMode: ThemeMode.system,
      home: const Home(),
    );
  }
}
