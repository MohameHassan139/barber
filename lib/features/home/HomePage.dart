import 'package:barber/features/profile/Profile_page.dart';
import 'package:barber/features/reservation/Appointments_page.dart';
import 'package:barber/features/reservation/Calendar%20Page.dart';
import 'package:barber/features/reservation/Search_barber_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _appointments = [];

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      SearchBarberPage(),
      AppointmentPage(
          appointments:
              _appointments), // AppointmentPage will reflect saved appointments
      ProfilePage(
          appointments: _appointments), // Pass appointments to ProfilePage
    ]);
  }

  // Bottom Navigation: handle the item tapped
  void _onItemTapped(int index) async {
    if (index == 0 || index == 2) {
      setState(() {
        _selectedIndex = index;
      });
    } else if (index == 1) {
      final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CalendarPage(
            bookedDates: const [],
          ), // Removed bookedDates
        ),
      );
      if (result != null && result is Map<String, dynamic>) {
        setState(() {
          _appointments.add(result); // Add new appointment to the list
        });
      }
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
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: 'Appointments'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}
