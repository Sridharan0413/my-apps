import 'package:flutter/material.dart';
import 'package:my_apps/category_product.dart';
import 'package:my_apps/home/home_page.dart';
import 'package:my_apps/home/cart_page.dart';
import 'package:my_apps/home/account_page.dart';
import 'package:my_apps/home/favourite.dart';

class ExplorePage extends StatefulWidget {
  final List<Map<String, dynamic>> allProducts;

  const ExplorePage({super.key, required this.allProducts});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> filteredCategories = [];

  final List<Map<String, String>> categories = [
    {'title': 'Fresh Fruits & Vegetable', 'image': 'images/frash_fruits.png'},
    {'title': 'Cooking Oil & Ghee', 'image': 'images/cooking_oil.png'},
    {'title': 'Meat & Fish', 'image': 'images/meat_fish.png'},
    {'title': 'Bakery & Snacks', 'image': 'images/bakery_snacks.png'},
    {'title': 'Dairy & Eggs', 'image': 'images/dairy_eggs.png'},
    {'title': 'Beverages', 'image': 'images/beverages.png'},
  ];

  int _selectedIndex = 1; // Explore tab

  @override
  void initState() {
    super.initState();
    filteredCategories = categories;
    _searchController.addListener(_filterCategories);
  }

  void _filterCategories() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      filteredCategories = categories
          .where((cat) => cat['title']!.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) =>  HomePage()),
        );
        break;
      case 1:
        // Already on ExplorePage, do nothing
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const MyCartPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) =>  FavoritePage()),
        );
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AccountPage()),
        );
        break;
    }
  }

  Color _getCategoryColor(int index) {
    final colors = [
      Colors.green.shade100,
      Colors.orange.shade100,
      Colors.red.shade100,
      Colors.purple.shade100,
      Colors.yellow.shade100,
      Colors.blue.shade100,
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Find Products', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Store',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: filteredCategories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 3 / 2.5,
                ),
                itemBuilder: (context, index) {
                  final category = filteredCategories[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CategoryProductsPage(
                            categoryName: category['title']!,
                            allProducts: widget.allProducts,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: _getCategoryColor(index),
                      ),
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Image.asset(category['image']!, fit: BoxFit.contain),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            category['title']!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favourite'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }
}







