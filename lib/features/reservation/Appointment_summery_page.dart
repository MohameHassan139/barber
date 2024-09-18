import 'package:barber/features/reservation/Calendar%20Page.dart';
import 'package:flutter/material.dart';

class AppointmentSummaryPage extends StatefulWidget {
  final List<Map<String, dynamic>> appointments;
  final Function(Map<String, dynamic>)
      onUpdate; // Callback to update appointment
  final Function(Map<String, dynamic>)
      onRemove; // Callback to remove appointment

  AppointmentSummaryPage({
    required this.appointments,
    required this.onUpdate,
    required this.onRemove,
  });

  @override
  _AppointmentSummaryPageState createState() => _AppointmentSummaryPageState();
}

class _AppointmentSummaryPageState extends State<AppointmentSummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Appointments"),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: widget.appointments.isEmpty
          ? const Center(child: Text("No appointments booked yet."))
          : ListView.builder(
              itemCount: widget.appointments.length,
              itemBuilder: (context, index) {
                DateTime date = widget.appointments[index]['date'];
                TimeOfDay time = widget.appointments[index]['time'];
                return ListTile(
                  leading: Icon(Icons.calendar_today),
                  title: Text("Date: ${date.day}/${date.month}/${date.year}"),
                  subtitle: Text("Time: ${time.format(context)}"),
                  trailing: PopupMenuButton<String>(
                    onSelected: (value) {
                      if (value == 'Edit') {
                        _editAppointment(widget.appointments[index]);
                      } else if (value == 'Remove') {
                        widget.onRemove(widget.appointments[index]);
                        setState(() {});
                      }
                    },
                    itemBuilder: (BuildContext context) =>
                        <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'Edit',
                        child: Text('Edit'),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Remove',
                        child: Text('Remove'),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }

  void _editAppointment(Map<String, dynamic> appointment) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CalendarPage(
          initialDate: appointment['date'],
          initialTime: appointment['time'],
          bookedDates: [],
        ),
      ),
    );
    if (result != null) {
      widget.onUpdate(result);
      Navigator.pop(context);
    }
  }
}
