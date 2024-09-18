import 'package:flutter/material.dart';

class SearchBarberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search for Barber Shop"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: "Search for a barber shop",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Sample search result
            ListTile(
              leading: const Icon(Icons.store),
              title: const Text("Barber Shop 1"),
              subtitle: const Text("Location: Cairo"),
              onTap: () {
                // Handle navigation to barber details
              },
            ),
          ],
        ),
      ),
    );
  }
}
