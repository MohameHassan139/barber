import 'package:flutter/material.dart';

class AppointmentSummaryPage extends StatelessWidget {
  final List<Map<String, dynamic>> appointments;

  const AppointmentSummaryPage({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Appointments"),
        backgroundColor: Colors.blueGrey[900],
        elevation: 10,
      ),
      body: appointments.isEmpty
          ? const Center(
              child: Text(
                "No appointments booked yet.",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
            )
          : ListView.builder(
              itemCount: appointments.length,
              padding: EdgeInsets.all(screenWidth * 0.03), // Responsive padding
              itemBuilder: (context, index) {
                DateTime date = appointments[index]['date'];
                TimeOfDay time = appointments[index]['time'];

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5, // Adjusted elevation
                  shadowColor: Colors.black.withOpacity(0.3),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.cyanAccent, Colors.blueAccent],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.05,
                          vertical: 15.0), // Responsive padding
                      leading: const Icon(
                        Icons.calendar_today,
                        color: Colors.white,
                        size: 30,
                      ),
                      title: Text(
                        "Date: ${date.day}/${date.month}/${date.year}",
                        style: TextStyle(
                          fontSize: screenWidth * 0.05, // Responsive font size
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      subtitle: Text(
                        "Time: ${time.format(context)}",
                        style: TextStyle(
                          fontSize: screenWidth * 0.04, // Responsive font size
                          color: Colors.white70,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.access_time,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
