import 'package:barber/features/Search_barber_page/salon_detail_page.dart';
import 'package:barber/features/home/HomePage.dart';
import 'package:flutter/material.dart';
// Ensure this path is correct

class SearchBarberPage extends StatefulWidget {
  const SearchBarberPage({super.key});

  @override
  _SearchBarberPageState createState() => _SearchBarberPageState();
}

class _SearchBarberPageState extends State<SearchBarberPage> {
  final List<Map<String, String>> _barberShops = [
    {"title": "Barber Shop 1", "subtitle": "Location: Cairo"},
    {"title": "Barber Shop 2", "subtitle": "Location: Alexandria"},
    {"title": "Barber Shop 3", "subtitle": "Location: Giza"},
    {"title": "Barber Shop 4", "subtitle": "Location: Menia"},
    {"title": "Barber Shop 5", "subtitle": "Location: Damietta"},
    {"title": "Barber Shop 6", "subtitle": "Location: Qena"},
    {"title": "Barber Shop 7", "subtitle": "Location: Aswan"},
    {"title": "Barber Shop 8", "subtitle": "Location: Port Said"},
    {"title": "Barber Shop 9", "subtitle": "Location: Beheira"},
    {"title": "Barber Shop 10", "subtitle": "Location: Sohag"},
    {"title": "Barber Shop 11", "subtitle": "Location: Luxor"},
    {"title": "Barber Shop 12", "subtitle": "Location: Tanta"},
    {"title": "Barber Shop 13", "subtitle": "Location: Zagazig"},
  ];

  List<Map<String, String>> _filteredBarberShops = [];

  @override
  void initState() {
    super.initState();
    _filteredBarberShops = _barberShops; // Initially show all barber shops
  }

  void _filterBarberShops(String query) {
    setState(() {
      _filteredBarberShops = _barberShops.where((shop) {
        return shop["title"]!.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search for Barber Shop"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Elevated and Stylish Search Bar with Gradient Border
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Colors.blueAccent, Colors.cyanAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                onChanged: _filterBarberShops,
                decoration: InputDecoration(
                  labelText: "Search for a barber shop",
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.search, color: Colors.blueGrey[800]),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Stylish List of Search Results with Gradient Cards
            Expanded(
              child: ListView(
                children: _filteredBarberShops.isNotEmpty
                    ? _filteredBarberShops
                        .map((shop) =>
                            _buildClickableBarberShopCard(context, shop))
                        .toList()
                    : [
                        Center(
                          child: Text(
                            'No results found',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blueGrey[600],
                            ),
                          ),
                        ),
                      ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClickableBarberShopCard(
      BuildContext context, Map<String, String> shop) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SalonDetailPage(
              title: shop["title"]!,
              subtitle: shop["subtitle"]!,
            ),
          ),
        );
      },
      child: _buildBarberShopCard(
        context,
        title: shop["title"]!,
        subtitle: shop["subtitle"]!,
        icon: Icons.store,
      ),
    );
  }

  Widget _buildBarberShopCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueGrey[100]!, Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.blueGrey[700]),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text(
            subtitle,
            style: TextStyle(
              color: Colors.blueGrey[600],
            ),
          ),
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
