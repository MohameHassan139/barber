import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class AppointmentPage extends StatefulWidget {
  final List<Map<String, dynamic>> appointments;

  AppointmentPage({required this.appointments});

  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  DateTime _selectedDay = DateTime.now();
  Map<DateTime, List<dynamic>> _appointments = {};

  @override
  void initState() {
    super.initState();
    _initializeAppointments();
  }

  void _initializeAppointments() {
    _appointments = {};
    for (var appointment in widget.appointments) {
      DateTime date = appointment['date'];
      if (_appointments[date] == null) {
        _appointments[date] = [];
      }
      _appointments[date]!.add(appointment);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Appointment Date'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _selectedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
              });
            },
            calendarFormat: CalendarFormat.month,
            eventLoader: (day) {
              return _appointments[day] ?? [];
            },
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
            ),
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              markerDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Save or handle the selected date
              Navigator.pop(context, {
                'date': _selectedDay,
                'appointments': _appointments[_selectedDay] ?? [],
              });
            },
            child: const Text('Confirm Date'),
          ),
        ],
      ),
    );
  }
}
