import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentSummary extends StatelessWidget {
  final DateTime selectedDay;
  final TimeOfDay selectedTime;

  const AppointmentSummary({
    super.key,
    required this.selectedDay,
    required this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    final String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDay);
    final String formattedTime = selectedTime.format(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Summary'),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Appointment Date: $formattedDate',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Appointment Time: $formattedTime',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                backgroundColor: Colors.blueGrey[800],
              ),
              child: const Text('Back to Calendar'),
            ),
          ],
        ),
      ),
    );
  }
}
