import 'package:barber/features/reservation/Appointments_page.dart';
import 'package:barber/features/profile/Profile_page.dart';
import 'package:barber/features/reservation/Search_barber_page.dart';
import 'package:barber/features/reservation/Calendar%20Page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> _appointments = [];

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      SearchBarberPage(), // Search page is now first
      AppointmentPage(
          appointments: _appointments), // Appointments page is second
      ProfilePage(appointments: _appointments), // Profile page is now last
    ]);
  }

  // Bottom Navigation: handle the item tapped
  void _onItemTapped(int index) async {
    if (index == 1) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              CalendarPage(bookedDates: []), // Updated with bookedDates
        ),
      );
      if (result != null && result is Map<String, dynamic>) {
        setState(() {
          _appointments.add(result); // Add new appointment to the list
        });
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.search), label: 'Search'), // Search is now first
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label: 'Appointments'), // Appointments is now second
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile'), // Profile is now last
        ],
      ),
    );
  }
}
