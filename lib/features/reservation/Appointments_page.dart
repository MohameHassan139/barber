import 'package:barber/features/favourite/favorites_page.dart';
import 'package:barber/features/profile/user_details_page.dart';
import 'package:barber/features/reservation/Appointment_summery_page.dart';
import 'package:flutter/material.dart';

class AppointmentPage extends StatelessWidget {
  final List<Map<String, dynamic>> appointments;

  const AppointmentPage({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Appointments"),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: appointments.isEmpty
          ? const Center(child: Text("No appointments booked yet."))
          : ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                DateTime date = appointments[index]['date'];
                TimeOfDay time = appointments[index]['time'];
                return ListTile(
                  leading: const Icon(Icons.calendar_today),
                  title: Text(
                    "Date: ${date.day}/${date.month}/${date.year}",
                  ),
                  subtitle: Text(
                    "Time: ${time.format(context)}",
                  ),
                );
              },
            ),
    );
  }

  // Method to style the "Your Appointments" button with special effects
  Widget _buildStylishAppointmentButton(
      BuildContext context, IconData icon, String title, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 10,
        shadowColor: Colors.greenAccent.withOpacity(0.5),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: const BoxDecoration(
              color: Colors.greenAccent,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 25),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.greenAccent,
            ),
          ),
          trailing:
              const Icon(Icons.arrow_forward_ios, color: Colors.greenAccent),
          tileColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
    );
  }

  // Navigation methods
  void _navigateToUserDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserDetailsPage()),
    );
  }

  void _navigateToFavorites(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FavoritesPage()),
    );
  }

  void _navigateToAppointments(BuildContext context) {
    if (appointments.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AppointmentSummaryPage(appointments: appointments),
        ),
      );
    }
  }

  void _navigateToSettings(BuildContext context) {
    // Implement navigation to settings
  }

  void _handleLogout(BuildContext context) {
    // Implement logout functionality
  }
}
