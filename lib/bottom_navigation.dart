import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final List<String> labels;
  final Function(int) onItemSelected;

  const BottomNavigation(
      {super.key, required this.selectedIndex, required this.onItemSelected, required this.labels});
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(

      selectedItemColor: Theme.of(context).colorScheme.primary,
        iconSize: 33.0,
        currentIndex: selectedIndex,
        onTap: onItemSelected,
        type: BottomNavigationBarType.fixed,
        items: [
      BottomNavigationBarItem(icon: const Icon(Icons.task_alt), label: labels[0]),
      BottomNavigationBarItem(icon: const Icon(Icons.search), label: labels[1])
    ]);
  }
}
