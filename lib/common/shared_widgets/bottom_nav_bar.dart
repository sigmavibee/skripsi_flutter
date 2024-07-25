import 'package:flutter/material.dart';
import 'package:stunting_project/components/colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final List<String> menuItems;
  final List<String> routes;
  final ValueChanged<int> onTap;

  final bool showSelectedLabels;
  final bool showUnselectedLabels;

  static final List<String> _menuItems = [
    'Home',
    'Article',
    'Gizi',
    'Diskusi',
    'Konsultasi',
  ];

  static final List<String> _routes = [
    'home',
    'article',
    'gizi',
    'discussion',
    'consultation',
  ];

  static final List<IconData> _icons = [
    Icons.home, // Home
    Icons
        .article, // Article (you can use Icons.description or Icons.newspaper if Icons.article is not available)
    Icons.food_bank, // Gizi
    Icons.chat, // Diskusi
    Icons.medical_services, // Konsultasi
  ];

  BottomNavBar({
    required this.currentIndex,
    required this.onTap,
    required this.menuItems,
    required this.routes,
    // this.selectedItemColor = Colors.blue,
    // this.selectedFontSize = 14,
    // this.unselectedItemColor = Colors.grey,
    // this.unselectedFontSize = 12,
    this.showSelectedLabels = true,
    this.showUnselectedLabels = true,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      currentIndex: currentIndex,
      selectedItemColor: successColor, // color of the selected icon
      unselectedItemColor: darkColor, // color of the unselected icon
      onTap: (index) {
        onTap(index);
        if (index != 0) {
          Navigator.pushNamed(context, routes[index]);
        }
      },
      items: _menuItems
          .map((item) => BottomNavigationBarItem(
                icon: Icon(_icons[
                    _menuItems.indexOf(item)]), // Wrap IconData with Icon
                label: item,
              ))
          .toList(),
    );
  }
}
