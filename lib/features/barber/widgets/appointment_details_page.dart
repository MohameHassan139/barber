import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentDetailsPage extends StatelessWidget {
  final String clientName;
  final String serviceType;
  final String timeSlot;
  final String date;
  final String barberName;
  final double price;
  final String status;

  const AppointmentDetailsPage({
    super.key,
    required this.clientName,
    required this.serviceType,
    required this.timeSlot,
    required this.date,
    required this.barberName,
    required this.price,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$clientName\'s Appointment',
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        color: Colors.teal[50],
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Appointment Details',
                style: GoogleFonts.poppins(
                  fontSize: screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800],
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow(Icons.workspace_premium, 'Service:',
                          serviceType, screenWidth),
                      const SizedBox(height: 10),
                      _buildDetailRow(
                          Icons.access_time, 'Time:', timeSlot, screenWidth),
                      const SizedBox(height: 10),
                      _buildDetailRow(
                          Icons.calendar_today, 'Date:', date, screenWidth),
                      const SizedBox(height: 10),
                      _buildDetailRow(
                          Icons.person, 'Barber:', barberName, screenWidth),
                      const SizedBox(height: 10),
                      _buildDetailRow(Icons.attach_money, 'Price:',
                          '\$${price.toStringAsFixed(2)}', screenWidth),
                      const SizedBox(height: 10),
                      _buildDetailRow(
                          Icons.check_circle, 'Status:', status, screenWidth),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildActionButton('Confirm', Colors.teal, () {
                    // Handle Confirm Action
                  }),
                  _buildActionButton('Cancel', Colors.red, () {
                    // Handle Cancel Action
                  }),
                  _buildActionButton('Reschedule', Colors.orange, () {
                    // Handle Reschedule Action
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(
      IconData icon, String title, String value, double screenWidth) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.teal[700]),
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: screenWidth * 0.045,
                fontWeight: FontWeight.w600,
                color: Colors.teal[700],
              ),
            ),
          ],
        ),
        Flexible(
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: screenWidth * 0.045,
            ),
            textAlign: TextAlign.end,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(String label, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins().copyWith(color: Colors.white),
      ),
    );
  }
}
