import 'package:barber/features/appoinments/Calendar%20Page.dart';
import 'package:barber/features/favourite/favorites_page.dart';
import 'package:barber/features/favourite/favorites_provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class SalonDetailPage extends StatefulWidget {
  final String title;
  final String subtitle;

  const SalonDetailPage({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  _SalonDetailPageState createState() => _SalonDetailPageState();
}

class _SalonDetailPageState extends State<SalonDetailPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _reviewsKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _locationKey = GlobalKey(); // New key for location section

  List<bool> selectedServices = List.filled(4, false);
  double? userRating = 0.0; // Start with zero stars

  void _toggleFavorite() {
    final provider = Provider.of<FavoritesProvider>(context, listen: false);

    final isFavorited = provider.isFavorite({
      'title': widget.title,
      'subtitle': widget.subtitle,
    });

    if (isFavorited) {
      provider.removeFavorite({
        'title': widget.title,
        'subtitle': widget.subtitle,
      });
    } else {
      provider.addFavorite({
        'title': widget.title,
        'subtitle': widget.subtitle,
      });
    }
  }

  void _viewFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoritesPage(
          favoriteShops: [],
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

  void _goToAppointmentPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CalendarPage(bookedDates: []),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        elevation: 4,
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
        actions: [
          IconButton(
            icon: Icon(
              provider.isFavorite({
                'title': widget.title,
                'subtitle': widget.subtitle,
              })
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: provider.isFavorite({
                'title': widget.title,
                'subtitle': widget.subtitle,
              })
                  ? Colors.red
                  : Colors.grey,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.subtitle,
                    style: const TextStyle(fontSize: 18, color: Colors.black54),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Rating bar with the save feature
                      RatingBar.builder(
                        initialRating: userRating!,
                        minRating: 0,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemSize: 24,
                        unratedColor: Colors.grey[300],
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            userRating = rating; // Save the rating
                          });
                        },
                      ),
                      ElevatedButton(
                        onPressed: userRating! > 0
                            ? () {
                                // Submit the rating (you can define your submission logic here)
                                print("Rating submitted: $userRating stars");
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.green),
                      const SizedBox(width: 4),
                      const Text(
                        'Open Now',
                        style: TextStyle(fontSize: 16, color: Colors.green),
                      ),
                      const SizedBox(width: 8),
                      const Text('9:00 AM - 7:00 PM',
                          style:
                              TextStyle(fontSize: 16, color: Colors.black54)),
                      IconButton(
                        icon: const Icon(Icons.arrow_downward),
                        onPressed: () => _scrollToSection(
                            _aboutKey), // Scroll to about section
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _sectionButton('Services', _servicesKey),
                      _sectionButton('Reviews', _reviewsKey),
                      _sectionButton('About', _aboutKey),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _sectionHeader('Popular Services'),
                  Container(
                    key: _servicesKey,
                    child: Column(
                      children: [
                        _serviceTile(0, 'Full Set',
                            '60 min | Titanium Manicure', '\$100.00'),
                        _serviceTile(1, 'Hair Cut', '45 min | Stylish Hair Cut',
                            '\$80.00'),
                        _serviceTile(2, 'Beard Grooming',
                            '30 min | Beard Trim and Shape', '\$60.00'),
                        _serviceTile(3, 'Relaxation Massage',
                            '60 min | Full Body', '\$120.00'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
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
                  _sectionHeader('About'),
                  Container(
                    key: _aboutKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        const Text('Location:',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        ClipRRect(
                          key: _locationKey, // Key for scrolling to map
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.asset(
                            'assets/images/map1.jpg',
                            width: double.infinity,
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
          if (selectedServices
              .contains(true)) // Show button only if a service is selected
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: _goToAppointmentPage,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.teal,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 32.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: const Text(
                    'Book Appointment',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // Helper method for section buttons (e.g., Services, Reviews, About)
  Widget _sectionButton(String label, GlobalKey key) {
    return GestureDetector(
      onTap: () => _scrollToSection(key),
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            height: 4,
            width: 60,
            color: Colors.teal,
          ),
        ],
      ),
    );
  }

  // Helper method for popular services section
  Widget _serviceTile(
      int index, String title, String description, String price) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedServices[index] = !selectedServices[index];
        });
      },
      child: Card(
        elevation: 2,
        child: ListTile(
          leading: Checkbox(
            value: selectedServices[index],
            onChanged: (bool? value) {
              setState(() {
                selectedServices[index] = value ?? false;
              });
            },
          ),
          title:
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(description),
          trailing: Text(price,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black)),
        ),
      ),
    );
  }

  // Helper method for the reviews section
  Widget _reviewTile(String reviewer, String review, int rating) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.teal,
        child: Text(
          reviewer[0],
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(reviewer),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(review),
          const SizedBox(height: 4),
          RatingBar.builder(
            initialRating: rating.toDouble(),
            minRating: 1,
            direction: Axis.horizontal,
            itemCount: 5,
            itemSize: 18,
            ignoreGestures: true,
            allowHalfRating: false,
            itemBuilder: (context, _) => const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {},
          ),
        ],
      ),
    );
  }

  // Helper method for opening hours
  Widget _openingHoursRow(String day, String hours, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
          Text(
            hours,
            style: TextStyle(fontSize: 16, color: color),
          ),
        ],
      ),
    );
  }

  // Helper method for the section header
  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
    );
  }
}
