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
  final _tabs = [const Wishlist(), const Search()];
  final _label = [
    'Wishlist',
    'Search',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigation(
          selectedIndex: _selectedIndex,
          onItemSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          labels: _label,
        ),
        body: _tabs[_selectedIndex]);
  }
}
