import 'package:flutter/material.dart';

class FavoritesProvider with ChangeNotifier {
  final List<Map<String, String>> _favoriteShops = [];

  List<Map<String, String>> get favoriteShops => _favoriteShops;

  void toggleFavorite(Map<String, String> shop) {
    if (_favoriteShops.contains(shop)) {
      _favoriteShops.remove(shop);
    } else {
      _favoriteShops.add(shop);
    }
    notifyListeners();
  }

  bool isFavorite(Map<String, String> shop) {
    return _favoriteShops.contains(shop);
  }
}
