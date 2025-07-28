import 'package:flutter/material.dart';

class FavoriteManager with ChangeNotifier {
  final List<Map<String, dynamic>> _favorites = [];

  List<Map<String, dynamic>> get favorites => _favorites;

  void addFavorite(Map<String, dynamic> product) {
    if (!_favorites.any((item) => item['name'] == product['name'])) {
      _favorites.add(product);
      notifyListeners();
    }
  }

  void removeFavorite(String productName) {
    _favorites.removeWhere((item) => item['name'] == productName);
    notifyListeners();
  }

  bool isFavorite(String productName) {
    return _favorites.any((item) => item['name'] == productName);
  }
}

