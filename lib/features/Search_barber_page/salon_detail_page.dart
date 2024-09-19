import 'package:barber/features/favourite/favorites_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SalonDetailPage extends StatefulWidget {
  final String title;
  final String subtitle;

  const SalonDetailPage({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  _SalonDetailPageState createState() => _SalonDetailPageState();
}

class _SalonDetailPageState extends State<SalonDetailPage> {
  bool isFavorite = false;
  final List<Map<String, String>> favoriteShops = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        elevation: 0,
        title: const Text(
          'Kadanama Salon',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.pinkAccent,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                        fontSize: 22,
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
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 8),
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
              const SizedBox(height: 8),
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
              const SizedBox(height: 16),
              // Section Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _sectionButton(context, 'Services'),
                  _sectionButton(context, 'Reviews'),
                  _sectionButton(context, 'About'),
                ],
              ),
              const SizedBox(height: 24),
              // Services Section
              _sectionHeader('Popular Services'),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 2,
                itemBuilder: (context, index) {
                  return const ListTile(
                    leading: Icon(Icons.check_circle_outline,
                        color: Colors.pinkAccent),
                    title: Text('Pełen zestaw'),
                    subtitle: Text('60 min | Manicure tytanowy'),
                    trailing: Text('100,00 zł',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  );
                },
              ),
              const SizedBox(height: 16),
              // Reviews Section
              _sectionHeader('Reviews'),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3, // Replace with actual number of reviews
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/images/avatar.jpg'),
                    ),
                    title: const Text('Mohamed Hassan'),
                    subtitle: const Text('Great experience!'),
                    trailing: RatingBar.builder(
                      initialRating: 4,
                      minRating: 1,
                      direction: Axis.horizontal,
                      itemCount: 5,
                      itemSize: 16,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        // Handle rating update
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
              // About Section
              _sectionHeader('About'),
              _buildAboutSection(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _viewFavorites,
        child: const Icon(Icons.favorite),
        backgroundColor: Colors.pinkAccent,
      ),
    );
  }

  Widget _sectionButton(BuildContext context, String label) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () {
        // Scroll to corresponding section (implement as needed)
      },
      child: Text(
        label,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  Widget _buildAboutSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        _buildOpeningHours(),
        const SizedBox(height: 16),
        const Text(
          'Information',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Image.asset(
            'assets/images/map1.jpg',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }

  Widget _buildOpeningHours() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Opening Hours',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        _buildDayRow('Monday', 'Closed', Colors.grey),
        _buildDayRow('Tuesday', '9:00 AM - 7:00 PM', Colors.green),
        _buildDayRow('Wednesday', '9:00 AM - 7:00 PM', Colors.green),
        _buildDayRow('Thursday', '9:00 AM - 7:00 PM', Colors.green),
        _buildDayRow('Friday', '9:00 AM - 7:00 PM', Colors.green),
        _buildDayRow('Saturday', '9:00 AM - 7:00 PM', Colors.green),
        _buildDayRow('Sunday', '9:00 AM - 7:00 PM', Colors.green),
        // Repeat for other days of the week
      ],
    );
  }

  Widget _buildDayRow(String day, String hours, Color dotColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            day,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Text(
            hours,
            style: const TextStyle(fontSize: 16, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
