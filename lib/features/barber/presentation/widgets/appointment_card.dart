import 'package:barber/features/barber/presentation/views/appointment_details.dart';
import 'package:barber/features/barber/presentation/widgets/appointment_details_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animations/animations.dart';

class AppointmentCard extends StatelessWidget {
  final Appointment appointment;

  const AppointmentCard({
    super.key,
    required this.appointment,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return OpenContainer(
      closedElevation: 4,
      transitionDuration: const Duration(milliseconds: 500),
      openBuilder: (context, _) => AppointmentDetailsPage(
        clientName: appointment.clientName,
        serviceType: appointment.serviceType,
        timeSlot: appointment.timeSlot,
        date: appointment.date,
        barberName: appointment.barberName,
        price: appointment.price,
        status: appointment.status,
      ),
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      closedColor: Colors.white,
      closedBuilder: (context, openContainer) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.teal[300],
            child: const Icon(Icons.person, color: Colors.white),
          ),
          title: Text(
            appointment.clientName,
            style: GoogleFonts.poppins(
              fontSize: screenWidth * 0.045,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appointment.serviceType,
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.04,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                appointment.timeSlot,
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.04,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                appointment.date,
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.035,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          trailing:
              const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.teal),
          onTap: openContainer,
        ),
      ),
    );
  }
}