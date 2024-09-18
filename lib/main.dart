import 'package:barber/features/profile/HomePage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BarberApp());
}

class BarberApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barbershop App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
