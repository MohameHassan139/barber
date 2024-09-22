import 'package:barber/features/appoinments/Calendar Page.dart';
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

class _SalonDetailPageState extends State<SalonDetailPage>
    with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _servicesKey = GlobalKey();
  final GlobalKey _reviewsKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _locationKey = GlobalKey();

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
    final isAnyServiceSelected = selectedServices.any((selected) => selected);

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
                    child: Hero(
                      tag: 'salon_image',
                      child: Image.asset(
                        'assets/images/salon1.jpeg',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
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
                      RatingBar.builder(
                        initialRating: userRating!,
                        minRating: 0,
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemSize:
                            30, // Increased star size for better visibility
                        unratedColor: Colors.grey[300],
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber, // Star color
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
                        onPressed: () => _scrollToSection(_aboutKey),
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
                          key: _locationKey,
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
          if (isAnyServiceSelected)
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: FloatingActionButton.extended(
                onPressed: () {
                  _goToAppointmentPage();
                  _buttonAnimationController.forward().then((value) {
                    _buttonAnimationController.reverse();
                  });
                },
                label: const Text('Book Appointment'),
                icon: const Icon(Icons.calendar_today),
                backgroundColor: Colors.teal,
              ),
            ),
        ],
      ),
    );
  }

  Widget _sectionButton(String title, GlobalKey key) {
    return GestureDetector(
      onTap: () => _scrollToSection(key),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _serviceTile(
      int index, String service, String duration, String price) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(service),
        subtitle: Text(duration),
        trailing: Text(price),
        onTap: () {
          setState(() {
            selectedServices[index] = !selectedServices[index];
          });
        },
        tileColor: selectedServices[index]
            ? Colors.teal.withOpacity(0.3)
            : null, // Increased opacity for better visibility
      ),
    );
  }

  Widget _reviewTile(String reviewer, String comment, int rating) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(reviewer),
        subtitle: Text(comment),
        trailing: RatingBarIndicator(
          rating: rating.toDouble(),
          itemCount: 5,
          itemSize: 20,
          direction: Axis.horizontal,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
        ),
      ),
    );
  }

  Widget _openingHoursRow(String day, String hours, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(day, style: const TextStyle(fontSize: 16)),
          Text(hours, style: TextStyle(fontSize: 16, color: color)),
        ],
      ),
    );
  }
}
