import 'package:flutter/material.dart';
import 'routine_page.dart';
import 'notices_page.dart';
import 'health_page.dart';
import 'calendar_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    NoticesPage(),
    RoutinePage(),
    HealthPage(),
    CalendarPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('CMEI App')),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.campaign), label: 'Avisos'),
          BottomNavigationBarItem(icon: Icon(Icons.schedule), label: 'Rotina'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Saúde'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendário'),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
