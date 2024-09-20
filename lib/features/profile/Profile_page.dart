import 'package:barber/features/data_performance/data_performance_page.dart';
import 'package:barber/features/favourite/favorites_page.dart';
import 'package:barber/features/profile/user_details_page.dart';
import 'package:barber/features/reservation/Appointment_summery_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final List<Map<String, dynamic>> appointments;

  const ProfilePage({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Calmer Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFB2DFDB),
                  Color(0xFF80CBC4)
                ], // Softer teal shades
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Profile Content
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar with Gradient Border
                Container(
                  padding: const EdgeInsets.all(4), // Border size
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFB2DFDB), Color(0xFF80CBC4)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blueGrey,
                    child: Text(
                      "IR", // User's initials
                      style: TextStyle(fontSize: 35, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Islam Ragab Ahmed", // User's name
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                // Profile Options
                Expanded(
                  child: ListView(
                    children: [
                      _buildStylishListTile(
                        context,
                        Icons.person,
                        "Your Details",
                        () => _navigateToUserDetails(context),
                      ),
                      _buildStylishFavoriteButton(
                        context,
                        Icons.favorite,
                        "Favorites",
                        () => _navigateToFavorites(context),
                      ),
                      _buildStylishListTile(
                        context,
                        Icons.calendar_today,
                        "Your Appointments",
                        () => _navigateToAppointments(context),
                      ),
                      _buildStylishListTile(
                        context,
                        Icons.settings,
                        "Data Preferences",
                        () => _navigateToSettings(context),
                      ),
                      _buildStylishListTile(
                        context,
                        Icons.logout,
                        "Logout",
                        () => _handleLogout(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Method to style the ListTile (for other buttons)
  Widget _buildStylishListTile(
      BuildContext context, IconData icon, String title, Function onTap) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 8,
      shadowColor: Colors.blueGrey.withOpacity(0.3),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.blueGrey[900],
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 25),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blueGrey),
        onTap: () => onTap(),
        tileColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }

  // Method to style the "Favorites" button with special effects
  Widget _buildStylishFavoriteButton(
      BuildContext context, IconData icon, String title, Function onTap) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 10,
        shadowColor: Colors.blueGrey.withOpacity(0.3),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey[900],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 25),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blueGrey),
          tileColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
        ),
      ),
    );
  }

  // Navigation methods
  void _navigateToUserDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const UserDetailsPage()),
    );
  }

  void _navigateToFavorites(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const FavoritesPage(
                favoriteShops: [],
              )),
    );
  }

  void _navigateToAppointments(BuildContext context) {
    if (appointments.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              AppointmentSummaryPage(appointments: appointments),
        ),
      );
    }
  }

  void _navigateToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DataPreferencesPage(),
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    // Implement logout functionality
  }
}
