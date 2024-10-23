import 'package:flutter/material.dart';

class AppointmentModel {
  String? barberId;
  String? userId;

  AppointmentModel({
    this.barberId,
    this.userId,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      barberId: json['barberId'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'barberId': barberId,
      'userId': userId,
    };
  }
}
