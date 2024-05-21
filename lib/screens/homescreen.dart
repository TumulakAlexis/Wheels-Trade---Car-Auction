import 'package:flutter/material.dart';
import 'package:wheels_trade/screens/home%20screens/screen1.dart';
import 'package:wheels_trade/screens/home%20screens/screen2.dart';
import 'package:wheels_trade/screens/home%20screens/screen3.dart';

class HomePageNav extends StatefulWidget {
  const HomePageNav({Key? key}) : super(key: key);

  @override
  State<HomePageNav> createState() => _HomePageNavState();
}

class _HomePageNavState extends State<HomePageNav> {
  int _selectedIndex = 0;

  // Define the list of views for each tab
  final List _pages = [
    Screen1(),
    Screen2(),
    Screen3(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: _pages[_selectedIndex], // Show the selected page
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // Set background color to grey
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedLabelStyle: TextStyle(color: Colors.white), // Set selected label color to white
        unselectedLabelStyle: TextStyle(color: Colors.white), // Set unselected label color to white
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color.fromARGB(255, 79, 99, 110)),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add, color: Color.fromARGB(255, 79, 99, 110)),
            label: 'Add Auction Item',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.house, color: Color.fromARGB(255, 79, 99, 110)),
            label: 'Auction House',
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    // Update the state when a tab is tapped
    setState(() {
      _selectedIndex = index;
    });
  }
}
