// models/appointment_model.dart
import 'package:flutter/material.dart';

class AppointmentModel {
  final DateTime date;
  final TimeOfDay time;
  final List<Map<String, dynamic>> selectedServices;

  AppointmentModel({
    required this.date,
    required this.time,
    required this.selectedServices,
  });
}
