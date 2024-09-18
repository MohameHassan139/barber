import 'package:barber/features/profile/Appointment_summery_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final List<Map<String, dynamic>> appointments;

  ProfilePage({required this.appointments});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _showSubtitle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar and Name
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blueGrey,
              child: Text(
                "IR", // User's initials
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Islam Ragab Ahmed", // User's name
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Profile Options
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text("Your Details"),
              onTap: () {
                // Navigate to user details
              },
            ),
            ListTile(
              leading: const Icon(Icons.favorite),
              title: const Text("Favorites"),
              onTap: () {
                // Navigate to user's favorite shops
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: const Text("Your Appointments"),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppointmentSummaryPage(
                      appointments: widget.appointments,
                      onUpdate: (updatedAppointment) {
                        setState(() {
                          // Update the existing appointment
                          int index = widget.appointments.indexWhere(
                              (appointment) =>
                                  appointment['date'] ==
                                      updatedAppointment['date'] &&
                                  appointment['time'] ==
                                      updatedAppointment['time']);
                          if (index != -1) {
                            widget.appointments[index] = updatedAppointment;
                          }
                          _showSubtitle = widget.appointments.isEmpty;
                        });
                      },
                      onRemove: (appointmentToRemove) {
                        setState(() {
                          widget.appointments.remove(appointmentToRemove);
                          _showSubtitle = widget.appointments.isEmpty;
                        });
                      },
                    ),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Data Preferences"),
              onTap: () {
                // Navigate to settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("Logout"),
              onTap: () {
                // Handle logout
              },
            ),
          ],
        ),
      ),
    );
  }
}
