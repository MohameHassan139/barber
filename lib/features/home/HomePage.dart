import 'package:barber/features/Search_barber_page/search_barber_page.dart';
import 'package:barber/features/reservation/Calendar%20Page.dart';
import 'package:flutter/material.dart';
import 'package:barber/features/profile/profile_page.dart';
import 'package:barber/features/reservation/appointments_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<Map<String, dynamic>> _appointments = [];

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const SearchBarberPage(),
      AppointmentPage(appointments: _appointments),
      ProfilePage(appointments: _appointments),
    ];
  }

  Future<void> _navigateToCalendarPage() async {
    final result = await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const CalendarPage(
          bookedDates: [], // Pass bookedDates if needed
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end);
          var offsetAnimation =
              animation.drive(tween.chain(CurveTween(curve: curve)));
          return SlideTransition(position: offsetAnimation, child: child);
        },
      ),
    );
    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        _appointments.add(result); // Add new appointment to the list
      });
    }
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      _navigateToCalendarPage();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: _pages,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.blueGrey[800]?.withOpacity(0.85),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.7),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.cyanAccent,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(fontFamily: 'Orbitron'),
          unselectedLabelStyle: const TextStyle(fontFamily: 'Orbitron'),
          showUnselectedLabels: true,
          showSelectedLabels: true,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined, size: 28),
              activeIcon: Icon(Icons.search, size: 28),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined, size: 28),
              activeIcon: Icon(Icons.calendar_today, size: 28),
              label: 'Appointments',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, size: 28),
              activeIcon: Icon(Icons.person, size: 28),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
