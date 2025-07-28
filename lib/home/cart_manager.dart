import 'package:flutter/material.dart';

class CartManager extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];
  final List<Map<String, dynamic>> _favourites = [];

  // ============================
  // CART SECTION
  // ============================
  List<Map<String, dynamic>> get items => List.unmodifiable(_items);

  double get totalPrice {
    return _items.fold(0.0, (sum, item) {
      final price = (item['totalPrice'] ?? 0).toDouble();
      return sum + price;
    });
  }

  int get itemCount {
    return _items.fold(0, (count, item) {
      final qty = item['quantityCount'] ?? 0;
      return count + (qty is int ? qty : int.tryParse(qty.toString()) ?? 0);
    });
  }

  void addItem(Map<String, dynamic> newItem) {
    final index = _items.indexWhere((item) => item['name'] == newItem['name']);

    if (index != -1) {
      final int change = newItem['quantityCount'] ?? 1;
      _items[index]['quantityCount'] =
          (_items[index]['quantityCount'] ?? 1) + change;

      if (_items[index]['quantityCount'] <= 0) {
        _items.removeAt(index);
      } else {
        final price = (_items[index]['price'] ?? 0).toDouble();
        final qty = _items[index]['quantityCount'];
        _items[index]['totalPrice'] = price * qty;
      }
    } else {
      final quantity = newItem['quantityCount'] ?? 1;
      final price = (newItem['price'] ?? 0).toDouble();
      newItem['quantityCount'] = quantity;
      newItem['totalPrice'] = price * quantity;
      _items.add(newItem);
    }

    notifyListeners();
  }

  void removeItemAt(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }

  // ============================
  // FAVOURITES SECTION (Cart-like)
  // ============================
  List<Map<String, dynamic>> get favouriteItems => List.unmodifiable(_favourites);

  double get favouritesTotalPrice {
    return _favourites.fold(0.0, (sum, item) {
      final price = (item['totalPrice'] ?? 0).toDouble();
      return sum + price;
    });
  }

  int get favouritesItemCount {
    return _favourites.fold(0, (count, item) {
      final qty = item['quantityCount'] ?? 0;
      return count + (qty is int ? qty : int.tryParse(qty.toString()) ?? 0);
    });
  }

  bool isFavourite(Map<String, dynamic> product) {
    return _favourites.any((item) => item['name'] == product['name']);
  }

  void addToFavourites(Map<String, dynamic> product) {
    final index = _favourites.indexWhere((item) => item['name'] == product['name']);

    if (index != -1) {
      final int change = product['quantityCount'] ?? 1;
      _favourites[index]['quantityCount'] =
          (_favourites[index]['quantityCount'] ?? 1) + change;

      if (_favourites[index]['quantityCount'] <= 0) {
        _favourites.removeAt(index);
      } else {
        final price = (_favourites[index]['price'] ?? 0).toDouble();
        final qty = _favourites[index]['quantityCount'];
        _favourites[index]['totalPrice'] = price * qty;
      }
    } else {
      final quantity = product['quantityCount'] ?? 1;
      final price = (product['price'] ?? 0).toDouble();
      product['quantityCount'] = quantity;
      product['totalPrice'] = price * quantity;
      _favourites.add(product);
    }

    notifyListeners();
  }

  void removeFavouriteAt(int index) {
    if (index >= 0 && index < _favourites.length) {
      _favourites.removeAt(index);
      notifyListeners();
    }
  }

  void removeFromFavourites(Map<String, dynamic> product) {
    int index = _favourites.indexWhere((item) => item['name'] == product['name']);
    if (index != -1) {
      _favourites.removeAt(index);
      notifyListeners();
    }
  }

  void clearFavourites() {
    _favourites.clear();
    notifyListeners();
  }
}



