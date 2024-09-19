import 'package:flutter/material.dart';

class ShopInfoPage extends StatelessWidget {
  final String title;
  final String subtitle;

  const ShopInfoPage({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stylish Header Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.blueAccent, Colors.cyanAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Details Section
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 18,
                color: Colors.blueGrey[600],
              ),
            ),
            const SizedBox(height: 20),
            // Contact Information Section
            Row(
              children: [
                Icon(Icons.phone, color: Colors.blueGrey[700]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Contact us at: 123-456-7890', // Placeholder for contact number
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.blueGrey[700],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Additional Information Section
            Text(
              'Additional details about the shop can go here. For example, you can include services offered, shop hours, etc.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.blueGrey[600],
              ),
            ),
            const SizedBox(height: 20),
            // Action Button
            ElevatedButton(
              onPressed: () {
                // Handle any actions like calling the shop or navigating to a map
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              ),
              child: const Text('Call Now'),
            ),
          ],
        ),
      ),
    );
  }
}
