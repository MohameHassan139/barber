import 'package:barber/features/favourite/favorites_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SalonDetailPage extends StatefulWidget {
  final String title;
  final String subtitle;

  const SalonDetailPage(
      {super.key, required this.title, required this.subtitle});

  @override
  _SalonDetailPageState createState() => _SalonDetailPageState();
}

class _SalonDetailPageState extends State<SalonDetailPage> {
  bool isFavorite = false;
  final List<Map<String, String>> favoriteShops = [];
  final ScrollController _scrollController = ScrollController();

  // Define GlobalKeys for each section
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _reviewsKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
      if (isFavorite) {
        favoriteShops.add({
          'title': widget.title,
          'subtitle': widget.subtitle,
        });
      } else {
        favoriteShops.removeWhere((shop) =>
            shop['title'] == widget.title &&
            shop['subtitle'] == widget.subtitle);
      }
    });
  }

  void _viewFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoritesPage(
          favoriteShops: favoriteShops,
        ),
      ),
    );
  }

  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        elevation: 0,
        title: const Text(
          'Kadanama Salon',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.asset(
                  'assets/images/salon1.jpeg',
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              // Title and Favorite Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87),
                  ),
                  IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: Colors.pinkAccent,
                    ),
                    onPressed: _toggleFavorite,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                widget.subtitle,
                style: const TextStyle(fontSize: 18, color: Colors.black54),
              ),
              const SizedBox(height: 16),
              // Rating Bar
              RatingBar.builder(
                initialRating: 4.5,
                minRating: 1,
                direction: Axis.horizontal,
                itemCount: 5,
                itemSize: 24,
                unratedColor: Colors.grey[300],
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  // Handle rating update
                },
              ),
              const SizedBox(height: 16),
              // Opening Hours
              const Row(
                children: [
                  Icon(Icons.access_time, color: Colors.green),
                  SizedBox(width: 4),
                  Text(
                    'Open Now',
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                  SizedBox(width: 8),
                  Text('9:00 AM - 7:00 PM',
                      style: TextStyle(fontSize: 16, color: Colors.black54)),
                ],
              ),
              const SizedBox(height: 24),
              // Section Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _sectionButton('Services', _servicesKey),
                  _sectionButton('Reviews', _reviewsKey),
                  _sectionButton('About', _aboutKey),
                ],
              ),
              const SizedBox(height: 24),
              // Services Section
              _sectionHeader('Popular Services'),
              Container(
                key: _servicesKey,
                child: Column(
                  children: [
                    _serviceTile(
                        'Full Set', '60 min | Titanium Manicure', '100,00 zł'),
                    _serviceTile(
                        'Hair Cut', '45 min | Stylish Hair Cut', '80,00 zł'),
                    _serviceTile('Beard Grooming',
                        '30 min | Beard Trim and Shape', '60,00 zł'),
                    _serviceTile('Relaxation Massage', '60 min | Full Body',
                        '120,00 zł'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Reviews Section
              _sectionHeader('Reviews'),
              Container(
                key: _reviewsKey,
                child: Column(
                  children: [
                    _reviewTile('Mohamed Hassan',
                        'Amazing service and friendly staff!', 5),
                    _reviewTile('Abdallah Abdalmonem',
                        'Great experience, highly recommended!', 4),
                    _reviewTile('Momen Raafat',
                        'Very professional and clean salon.', 5),
                    _reviewTile('Islam Ragab',
                        'Amazing service and friendly staff!', 4),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // About Section with updated style
              _sectionHeader('About'),
              Container(
                key: _aboutKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Opening Hours'),
                    _openingHoursRow('Monday', 'Closed', Colors.grey),
                    _openingHoursRow(
                        'Tuesday', '9:00 AM - 7:00 PM', Colors.green),
                    _openingHoursRow(
                        'Wednesday', '9:00 AM - 7:00 PM', Colors.green),
                    _openingHoursRow(
                        'Thursday', '9:00 AM - 7:00 PM', Colors.green),
                    _openingHoursRow(
                        'Friday', '9:00 AM - 7:00 PM', Colors.green),
                    _openingHoursRow(
                        'Saturday', '9:00 AM - 7:00 PM', Colors.green),
                    _openingHoursRow('Sunday', 'Closed', Colors.grey),
                    const SizedBox(height: 16),
                    const Text('Information'),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: Image.asset(
                        'assets/images/map1.jpg', // Changed to asset image
                        width: 300,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionButton(String label, GlobalKey key) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        _scrollToSection(key);
      },
      child: Text(label),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 4,
            decoration: BoxDecoration(
              color: Colors.pinkAccent,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 1.2,
              fontFamily: 'Raleway', // Stylish font
            ),
          ),
          const Spacer(),
          const Icon(Icons.info_outline, color: Colors.pinkAccent),
        ],
      ),
    );
  }

  Widget _serviceTile(String title, String subtitle, String price) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        leading:
            const Icon(Icons.check_circle_outline, color: Colors.pinkAccent),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: Text(price, style: const TextStyle(color: Colors.pinkAccent)),
      ),
    );
  }

  Widget _reviewTile(String reviewer, String review, double rating) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        leading: const Icon(Icons.person, color: Colors.pinkAccent),
        title: Text(
          reviewer,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(review),
        trailing: RatingBarIndicator(
          rating: rating,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemCount: 5,
          itemSize: 20,
          direction: Axis.horizontal,
        ),
      ),
    );
  }

  Widget _openingHoursRow(String day, String hours, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day, style: const TextStyle(fontSize: 16)),
          Text(hours, style: TextStyle(fontSize: 16, color: textColor)),
        ],
      ),
    );
  }
}
