import 'package:barber/features/Search_barber_page/salon_detail_page.dart';
import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  final List<Map<String, String>> favoriteShops;

  const FavoritesPage({Key? key, required this.favoriteShops})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Favorites",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.redAccent, Colors.pinkAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 4,
      ),
      body: favoriteShops.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border,
                      size: 100, color: Colors.redAccent.withOpacity(0.5)),
                  const SizedBox(height: 20),
                  const Text(
                    "No Favorites Yet!",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Start adding your favorite shops!",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                itemCount: favoriteShops.length,
                itemBuilder: (context, index) {
                  final shop = favoriteShops[index];

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 15),
                      leading: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.redAccent.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.favorite,
                          color: Colors.redAccent,
                          size: 30,
                        ),
                      ),
                      title: Text(
                        shop['title']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        shop['subtitle']!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.chevron_right,
                          color: Colors.redAccent,
                        ),
                        onPressed: () {
                          // Navigate to SalonDetailPage when chevron is pressed
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SalonDetailPage(
                                title: shop['title']!,
                                subtitle: shop['subtitle']!,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
