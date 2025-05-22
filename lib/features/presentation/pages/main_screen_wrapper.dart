// main_screen_wrapper.dart
import 'package:flutter/material.dart';
import 'home_page.dart'; // Import your existing HomePage
import 'categories_page.dart'; // New placeholder page
import 'cart_page.dart';      // New placeholder page
import 'profile_page.dart';    // New placeholder page

class MainScreenWrapper extends StatefulWidget {
  const MainScreenWrapper({Key? key}) : super(key: key);

  @override
  State<MainScreenWrapper> createState() => _MainScreenWrapperState();
}

class _MainScreenWrapperState extends State<MainScreenWrapper> {
  int _selectedIndex = 0; // Tracks the currently selected tab

  // List of pages to display in the bottom navigation bar
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),         // Index 0
    CategoriesPage(),   // Index 1
    CartPage(),         // Index 2
    ProfilePage(),      // Index 3
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body will display the selected page
      body: IndexedStack( // Keeps all pages alive, preserving their state
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category_outlined),
            activeIcon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            activeIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, // Highlights the selected item
        selectedItemColor: Theme.of(context).primaryColor, // Color for selected icon/label
        unselectedItemColor: Colors.grey, // Color for unselected icons/labels
        onTap: _onItemTapped, // Callback when an item is tapped
        type: BottomNavigationBarType.fixed, // Ensures all labels are shown
      ),
    );
  }
}