import 'package:barber/features/appoinments/Appointment_summery_page.dart';
import 'package:barber/features/data_performance/data_performance_page.dart';
import 'package:barber/features/favourite/favorites_page.dart';
import 'package:barber/features/favourite/favorites_provide.dart';
import 'package:barber/features/profile/user_details_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  final List<Map<String, dynamic>> appointments;

  const ProfilePage({super.key, required this.appointments});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;

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
                      Color(0xFFE1F5FE),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              // Profile Content
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Avatar with Gradient Border
                    GestureDetector(
                      onTap: () => _showProfilePictureOptions(context),
                      child: Container(
                        padding: const EdgeInsets.all(6),
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
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Islam Ragab Ahmed", // User's name
                      style: TextStyle(
                        fontSize:
                            screenWidth > 600 ? 30 : 25, // Responsive text size
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey,
                      ),
                    ),
                    const SizedBox(height: 10), // Add spacing
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
      },
    );
  }

  // Method to style the ListTile
  Widget _buildStylishListTile(
      BuildContext context, IconData icon, String title, Function onTap) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 6,
      shadowColor: Colors.blueGrey.withOpacity(0.3),
      child: SizedBox(
        height: 60,
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey[900],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey,
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, color: Colors.blueGrey),
          onTap: () => onTap(),
          tileColor: Colors.white,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
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
    // Simulating logout action
    final snackBar = SnackBar(
      content: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Logged out successfully!',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          // TextButton(
          //   onPressed: () {
          // Optionally, implement any action on button press
          // Navigator.of(context).pop(); // Close the snackbar
          //   },
          //   child: const Text(
          //     'UNDO',
          //     style: TextStyle(
          //         color: Colors.yellowAccent), // Customize button color
          //   ),
          // ),
        ],
      ),
      backgroundColor: Colors.blueGrey[900], // Modern background color
      duration: const Duration(seconds: 1),
      behavior: SnackBarBehavior.floating, // Floating snackbar
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15), // Rounded corners
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showProfilePictureOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor:
          Colors.transparent, // Makes background transparent for card effect
      builder: (BuildContext context) {
        return Card(
          elevation: 8, // Increased elevation for a more prominent shadow
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(20)), // Rounded top corners
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Choose Profile Picture',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey, // Matching with the theme
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const Icon(Icons.camera_alt,
                      color: Colors.blueGrey, size: 30),
                  title: const Text(
                    'Camera',
                    style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    // Handle the selected image from camera here
                  },
                ),
                const Divider(height: 2), // Divider for better separation
                ListTile(
                  leading:
                      const Icon(Icons.photo, color: Colors.blueGrey, size: 30),
                  title: const Text(
                    'Gallery',
                    style: TextStyle(fontSize: 18, color: Colors.blueGrey),
                  ),
                  onTap: () async {
                    Navigator.pop(context);
                    // Handle the selected image from gallery here
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
