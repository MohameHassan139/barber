import 'package:flutter/material.dart';

class CalendarPage extends StatefulWidget {
  final DateTime? initialDate;
  final TimeOfDay? initialTime;

  CalendarPage({
    this.initialDate,
    this.initialTime,
    required List bookedDates,
  });

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate ?? DateTime.now();
    _selectedTime = widget.initialTime ?? TimeOfDay.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Appointment"),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: Text(_selectedDate == null
                ? "Select Date"
                : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"),
            onTap: _pickDate,
          ),
          ListTile(
            leading: const Icon(Icons.access_time),
            title: Text(_selectedTime == null
                ? "Select Time"
                : _selectedTime!.format(context)),
            onTap: _pickTime,
          ),
          ElevatedButton(
            onPressed: _selectedDate != null && _selectedTime != null
                ? () {
                    Navigator.pop(context, {
                      "date": _selectedDate!,
                      "time": _selectedTime!,
                    });
                  }
                : null,
            child: const Text("Save Appointment"),
          ),
        ],
      ),
    );
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate!,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime!,
    );
    if (pickedTime != null) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }
}
