import 'package:barber/features/appoinments/calendar_page.dart';
import 'package:barber/features/services/services_page.dart';
import 'package:flutter/material.dart';
import 'package:barber/features/favourite/favorites_provide.dart';
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

class _SalonDetailPageState extends State<SalonDetailPage>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _reviewsKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  List<Map<String, dynamic>> appointments = []; // List to store appointments

  List<bool> selectedServices = List.filled(4, false);
  double? userRating = 0.0;

  late AnimationController _buttonAnimationController;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();
    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _buttonAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _buttonAnimationController.dispose();
    super.dispose();
  }

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

  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _goToAppointmentPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CalendarPage(
          bookedDates: [],
          selectedServices: [],
          onAppointmentSaved: (appointmentData) {},
        ), // Pass booked dates if any
      ),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        appointments.add(result); // Add the new appointment to the list
      });
    }
  }

  void _showRatingMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Thank you for your rating!'),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.teal,
      ),
    );
  }

  // Widget to display appointments summary
// Widget to display appointments summary
  Widget _appointmentSummary() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: appointments.map((appointment) {
        final service = appointment['service'] ?? 'Unknown Service';
        final date = appointment['date'] != null
            ? appointment['date'].toString()
            : 'Unknown Date';

        return ListTile(
          title: Text(service),
          subtitle: Text('Date: $date'),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavoritesProvider>(context);
    final isAnyServiceSelected = selectedServices.any((selected) => selected);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

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
              padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Hero(
                      tag: 'salon_image',
                      child: Image.asset(
                        'assets/images/salon1.jpeg',
                        height: screenHeight * 0.25, // Responsive height
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: screenWidth * 0.06, // Responsive font size
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    widget.subtitle,
                    style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        color: Colors.black54), // Responsive font size
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBar.builder(
                        initialRating: userRating!,
                        minRating: 0,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemSize: screenWidth * 0.07, // Responsive icon size
                        unratedColor: Colors.grey[300],
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          setState(() {
                            userRating = rating;
                          });
                        },
                      ),
                      ScaleTransition(
                        scale: _buttonScaleAnimation,
                        child: ElevatedButton(
                          onPressed: userRating! > 0
                              ? () {
                                  _showRatingMessage();
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
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
                          style:
                              TextStyle(fontSize: 16, color: Colors.black54)),
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
                  _sectionHeader('Select Services'),
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
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  _sectionHeader(
                      'Your Appointments'), // New section for appointments
                  _appointmentSummary(), // Display appointments here
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
              color: Colors.white,
              child: ElevatedButton(
                onPressed: () {
                  // Navigate to the ServicesPage directly
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ServicesPage(), // Navigate to ServicesPage
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(
                    vertical: screenHeight * 0.02, // Responsive padding
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Book now',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }

  Widget _sectionButton(String title, GlobalKey key) {
    return GestureDetector(
      onTap: () => _scrollToSection(key),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            width: 60,
            height: 2,
            color: Colors.teal,
          ),
        ],
      ),
    );
  }

  Widget _serviceTile(
      int index, String title, String description, String price) {
    return ListTile(
      title: Text(title),
      subtitle: Text(description),
      trailing: Text(price),
    );
  }

  Widget _reviewTile(String name, String review, double rating) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.teal,
        child: Text(
          name.substring(0, 1),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(review),
          const SizedBox(height: 4),
          Row(
            children: List.generate(
              rating.toInt(),
              (index) => const Icon(
                Icons.star,
                size: 16,
                color: Colors.amber,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
