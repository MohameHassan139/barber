import 'package:flutter/material.dart';

class CalendarPage extends StatelessWidget {
  final List<DateTime> bookedDates;
  final List<String> selectedServices;
  final Function(DateTime) onAppointmentSaved;

  const CalendarPage({
    Key? key,
    required this.bookedDates,
    required this.selectedServices,
    required this.onAppointmentSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Your calendar implementation here
    // When the user selects a date, call onAppointmentSaved with the selected date
    DateTime selectedDate = DateTime.now(); // Example selected date
    onAppointmentSaved(
        selectedDate); // Call this when the user confirms the appointment
    return Container(); // Replace with your actual UI
  }
}
