import 'package:barber/features/appoinments/Appointment_summery_page.dart';
import 'package:barber/features/data_performance/data_performance_page.dart';
import 'package:barber/features/favourite/favorites_page.dart';
import 'package:barber/features/favourite/favorites_provide.dart';
import 'package:barber/features/profile/user_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  final List<Map<String, dynamic>> appointments;

  const ProfilePage({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFB3E5FC),
                  Color(0xFFE1F5FE)
                ], // Use colors from SalonDetailPage
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Profile Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar with Gradient Border
                Container(
                  padding: const EdgeInsets.all(6), // Border size
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFB3E5FC), Color(0xFFE1F5FE)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(
                    radius: 55,
                    backgroundColor: Colors.blueGrey,
                    child: Text(
                      "IR", // User's initials
                      style: TextStyle(fontSize: 40, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Islam Ragab Ahmed", // User's name
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),

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
                      _buildStylishListTile(
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

  // Method to style the ListTile (for all buttons)
  Widget _buildStylishListTile(
      BuildContext context, IconData icon, String title, Function onTap) {
    return Card(
      margin:
          const EdgeInsets.symmetric(vertical: 5), // Reduced vertical margin
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(15), // Slightly reduced border radius
      ),
      elevation: 6, // Reduced elevation for a smaller effect
      shadowColor: Colors.blueGrey.withOpacity(0.3), // Softer shadow
      child: SizedBox(
        height: 60, // Reduced height for smaller cards
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8.0), // Reduced padding for icon
            decoration: BoxDecoration(
              color: Colors.blueGrey[900],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 24), // Smaller icon
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 14, // Reduced font size
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blueGrey),
          onTap: () => onTap(),
          tileColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0, vertical: 10.0), // Slightly reduced padding
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                15.0), // Consistent border radius with card
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
    final favoritesProvider =
        Provider.of<FavoritesProvider>(context, listen: false);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            FavoritesPage(favoriteShops: favoritesProvider.favoriteShops),
      ),
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
