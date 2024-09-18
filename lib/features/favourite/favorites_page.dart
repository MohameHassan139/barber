// FavoritesPage to navigate to
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        centerTitle: true,
        backgroundColor: Colors.redAccent,
      ),
      body: const Center(
        child: Text(
          "No Favorites Yet!",
          style: TextStyle(fontSize: 20, color: Colors.redAccent),
        ),
      ),
    );
  }
}
