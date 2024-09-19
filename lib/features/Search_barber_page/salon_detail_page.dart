import 'package:barber/features/Search_barber_page/Search_barber_page.dart';
import 'package:barber/features/favourite/favorites_page.dart';
import 'package:barber/features/home/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SalonDetailPage extends StatefulWidget {
  const SalonDetailPage(
      {super.key, required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  _SalonDetailPageState createState() => _SalonDetailPageState();
}

class _SalonDetailPageState extends State<SalonDetailPage> {
  // List to hold favorite barber shops
  List<Map<String, String>> favoriteShops = [];

  // Flag to track if this barber shop is favorited
  bool isFavorited = false;

  // Snackbar for feedback when adding/removing from favorites
  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.blueGrey[900],
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          widget.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blueGrey[900],
        elevation: 5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            );
          },
        ),
        actions: [
          // Button to navigate to FavoritesPage
          IconButton(
            icon: const Icon(Icons.favorite),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      FavoritesPage(favoriteShops: favoriteShops),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Salon Image with stylish shadow and rounded corners
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/images/salon1.jpeg',
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Salon title and dynamic favorite icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueGrey[900],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorited ? Icons.favorite : Icons.favorite_border,
                      color: isFavorited ? Colors.redAccent : Colors.grey,
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        isFavorited = !isFavorited;

                        if (isFavorited) {
                          // Add to favorites
                          favoriteShops.add({
                            'title': widget.title,
                            'subtitle': widget.subtitle,
                          });
                          _showSnackbar('Added to favorites!');
                        } else {
                          // Remove from favorites
                          favoriteShops.removeWhere(
                              (shop) => shop['title'] == widget.title);
                          _showSnackbar('Removed from favorites!');
                        }
                      });
                    },
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Location
              Text(
                '1 Maja 323',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey[700],
                ),
              ),
              const SizedBox(height: 16),

              // Rating bar with gradient background
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blueGrey[50]!, Colors.white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Center(
                  child: RatingBar.builder(
                    initialRating: 4,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 24,
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      // Handle rating update
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Open hours with stylish row
              Row(
                children: [
                  Icon(Icons.access_time, color: Colors.blueGrey[700]),
                  const SizedBox(width: 4),
                  Text(
                    'Open Now',
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '9:00 AM - 7:00 PM',
                    style: TextStyle(color: Colors.blueGrey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Buttons for Services, Reviews, About with improved style
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildElevatedButton(
                    context,
                    text: 'Services',
                    icon: Icons.design_services,
                    onPressed: () {
                      // Handle "Services" button
                    },
                  ),
                  _buildElevatedButton(
                    context,
                    text: 'Reviews',
                    icon: Icons.comment,
                    onPressed: () {
                      // Handle "Reviews" button
                    },
                  ),
                  _buildElevatedButton(
                    context,
                    text: 'About',
                    icon: Icons.info_outline,
                    onPressed: () {
                      // Handle "About" button
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build stylish elevated buttons
  Widget _buildElevatedButton(BuildContext context,
      {required String text,
      required IconData icon,
      required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 20),
      label: Text(text),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey[900],
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 5,
      ),
    );
  }
}
