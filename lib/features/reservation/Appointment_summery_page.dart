import 'package:barber/features/reservation/Calendar%20Page.dart';
import 'package:flutter/material.dart';

class AppointmentSummaryPage extends StatelessWidget {
  final List<Map<String, dynamic>> appointments;

  AppointmentSummaryPage({required this.appointments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Appointments"),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: ListView.builder(
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          DateTime date = appointments[index]['date'];
          TimeOfDay time = appointments[index]['time'];
          return ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text("Date: ${date.day}/${date.month}/${date.year}"),
            subtitle: Text("Time: ${time.format(context)}"),
            trailing: IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _editAppointment(context, index, date, time),
            ),
          );
        },
      ),
    );
  }

  void _editAppointment(
      BuildContext context, int index, DateTime date, TimeOfDay time) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CalendarPage(
          initialDate: date,
          initialTime: time,
          bookedDates: [], // Pass booked dates if necessary
        ),
      ),
    ).then((result) {
      if (result != null) {
        appointments[index]['date'] = result['date'];
        appointments[index]['time'] = result['time'];
      }
    });
  }
}
