import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_apps/home/cart_manager.dart';
import 'package:my_apps/home/favourite_manager.dart'; 

class ProductDetailPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantityCount = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final favoriteManager = Provider.of<FavoriteManager>(context);
    final bool isFavorited = favoriteManager.isFavorite(product['name']);
    final double totalPrice = quantityCount * (product['price'] as double);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Product Detail"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Center(
                child: Image.asset(
                  product['image'],
                  height: 200,
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: IconButton(
                  icon: Icon(
                    isFavorited ? Icons.favorite : Icons.favorite_border,
                    color: isFavorited ? Colors.red : Colors.grey,
                    size: 28,
                  ),
                  onPressed: () {
                    final favoriteProduct = {
                      'name': product['name'],
                      'price': product['price'],
                      'image': product['image'],
                      'quantity': product['quantity'],
                      'category': product['category'],
                      'brand': product['brand'],
                    };

                    if (isFavorited) {
                      favoriteManager.removeFavorite(product['name']);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Removed from favorites")),
                      );
                    } else {
                      favoriteManager.addFavorite(favoriteProduct);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Added to favorites")),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'],
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  product['quantity'],
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (quantityCount > 1) {
                          setState(() {
                            quantityCount--;
                          });
                        }
                      },
                      icon: const Icon(Icons.remove_circle_outline),
                    ),
                    Text(
                      quantityCount.toString(),
                      style: const TextStyle(fontSize: 16),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          quantityCount++;
                        });
                      },
                      icon: const Icon(Icons.add_circle_outline),
                    ),
                    const Spacer(),
                    Text(
                      "₹${totalPrice.toStringAsFixed(2)}",
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ExpansionTile(
                  title: const Text("Product Detail"),
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Apples are nutritious. Apples may be good for weight loss. "
                        "Apples may be good for your heart. As part of a healthful and varied diet.",
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                ListTile(
                  title: const Text("Nutritions"),
                  trailing: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text("100g"),
                  ),
                ),
                const Divider(),
                ListTile(
                  title: const Text("Review"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(5, (index) {
                      return const Icon(Icons.star, color: Colors.orange, size: 20);
                    }),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                final productToAdd = {
                  'name': product['name'],
                  'price': product['price'],
                  'image': product['image'],
                  'quantity': product['quantity'],
                  'category': product['category'],
                  'brand': product['brand'],
                  'quantityCount': quantityCount,
                  'totalPrice': totalPrice,
                };

                Provider.of<CartManager>(context, listen: false).addItem(productToAdd);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Added to cart")),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Add To Basket",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}




