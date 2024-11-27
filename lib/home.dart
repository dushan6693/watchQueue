import 'package:flutter/material.dart';
import 'bottom_nav/search.dart';
import 'bottom_nav/wishlist.dart';
import 'bottom_navigation.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  String title = 'Uni Chat';
  final tabs = [ const Wishlist(), const Search()];
  final label = ['Wishlist', 'Search',];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).colorScheme.surface,
      // appBar: AppBar(
      //   title: Text(label[_selectedIndex]),
      //   centerTitle: true,
      //   elevation: 5.0,
      //   shadowColor: Colors.black12,
      // ),
      bottomNavigationBar: BottomNavigation(
          selectedIndex: _selectedIndex,
          onItemSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          }
          ,labels: label,),
      body: tabs[_selectedIndex],
    );
  }
}
