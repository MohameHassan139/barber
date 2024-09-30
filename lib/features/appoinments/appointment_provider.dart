// providers/appointment_provider.dart
import 'package:barber/models/appointment_model.dart';
import 'package:flutter/material.dart';

class AppointmentProvider with ChangeNotifier {
  AppointmentModel? _appointment;

  AppointmentModel? get appointment => _appointment;

  void saveAppointment(AppointmentModel appointment) {
    _appointment = appointment;
    notifyListeners();
  }
}
