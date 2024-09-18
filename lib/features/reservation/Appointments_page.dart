import 'package:flutter/material.dart';

class AppointmentPage extends StatelessWidget {
  final List<Map<String, dynamic>> appointments;

  AppointmentPage({required this.appointments});

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
                  leading: Icon(Icons.calendar_today),
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
}
