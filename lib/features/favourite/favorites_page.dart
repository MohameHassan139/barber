import 'package:barber/features/favourite/favorites_provide.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  final List<Map<String, String>> favoriteShops;

  const FavoritesPage({super.key, required this.favoriteShops});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorites"),
        backgroundColor: Colors.blueAccent, // Use same color scheme
      ),
      body: ListView.builder(
        itemCount: favoritesProvider.favoriteShops.length,
        itemBuilder: (context, index) {
          final shop = favoritesProvider.favoriteShops[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 4,
            child: ListTile(
              title: Text(shop['title'] ?? ''),
              subtitle: Text(shop['subtitle'] ?? ''),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.redAccent),
                onPressed: () {
                  favoritesProvider.removeFavorite(shop);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
