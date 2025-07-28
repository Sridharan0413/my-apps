import 'package:flutter/material.dart';
import 'package:my_apps/home/explore_page.dart';
import 'package:my_apps/product/product_detail page.dart';
import 'package:my_apps/filter_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> exclusiveProducts = [
    {
      'name': 'Organic Bananas',
      'quantity': '7pcs, Price',
      'price': 3.99,
      'image': 'images/banana.png',
      'category': 'Fruits',
      'brand': 'OrganicFarm'
    },
    {
      'name': 'Red Apple',
      'quantity': '1kg, Price',
      'price': 5.99,
      'image': 'images/apple_red.png',
      'category': 'Fruits',
      'brand': 'OrganicFarm'
    },
    {
      'name': 'Egg Noodels',
      'quantity': '2 pockets, Price',
      'price': 2.99,
      'image': 'images/egg_noodles.png',
      'category': 'Noodles & Pasta',
      'brand': 'Pasta'
    },
    {
      'name': 'Rice',
      'quantity': '5kg, Price',
      'price': 4.99,
      'image': 'images/rice.png',
      'category': 'Rice',
      'brand': 'LC112'
    }
  ];

  final List<Map<String, dynamic>> juiceitems = [
    {
      'name': 'Pepsi',
      'quantity': '1, Price',
      'price': 4.99,
      'image': 'images/pepsi_can.png',
      'category': 'Beverages',
      'brand': 'Pepsi'
    },
    {
      'name': 'Sprite',
      'quantity': '1, Price',
      'price': 5.99,
      'image': 'images/sprite_can.png',
      'category': 'Beverages',
      'brand': 'Sprite'
    },
    {
      'name': 'Diet Coke',
      'quantity': '1, Price',
      'price': 2.99,
      'image': 'images/diet_coke.png',
      'category': 'Beverages',
      'brand': 'Cocacola'
    },
    {
      'name': 'Grape Juice',
      'quantity': '1, Price',
      'price': 4.99,
      'image': 'images/juice_apple_grape.png',
      'category': 'FruitJuice',
      'brand': 'AppleGrape'
    }
  ];

  final List<Map<String, dynamic>> bestSellingProducts = [
    {
      'name': 'Cocacola',
      'quantity': '1, Price',
      'price': 3.49,
      'image': 'images/cocacola_can.png',
      'category': 'Beverages',
      'brand': 'Cocacola'
    },
    {
      'name': 'Ginger',
      'quantity': '1pc, Price',
      'price': 2.99,
      'image': 'images/ginger.png',
      'category': 'Vegetable',
      'brand': 'Cooking Item'
    },
    {
      'name': 'Red Capcicum',
      'quantity': '1kg, Price',
      'price': 3.49,
      'image': 'images/bell_pepper_red.png',
      'category': 'Vegetable',
      'brand': 'Cooking Item'
    },
    {
      'name': 'Beef Bone',
      'quantity': '1pc, Price',
      'price': 2.99,
      'image': 'images/beef_bone.png',
      'category': 'Meat',
      'brand': 'Cooking Item'
    }
  ];

  List<Map<String, dynamic>> allProducts = [];
  List<Map<String, dynamic>> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    allProducts.addAll(exclusiveProducts);
    allProducts.addAll(juiceitems);
    allProducts.addAll(bestSellingProducts);
    filteredProducts = allProducts;
  }

  void _openFilterPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FilterPage(products: allProducts),
      ),
    );

    if (result != null && result is Map<String, Set<String>>) {
      final selectedCategories = result['categories'] ?? {};
      final selectedBrands = result['brands'] ?? {};

      setState(() {
        filteredProducts = allProducts.where((product) {
          final categoryMatch = selectedCategories.isEmpty || selectedCategories.contains(product['category']);
          final brandMatch = selectedBrands.isEmpty || selectedBrands.contains(product['brand']);
          return categoryMatch && brandMatch;
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: const Icon(Icons.location_on, color: Colors.black),
        title: const Text("TamilNadu, Sivagangai", style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.black),
            onPressed: _openFilterPage,
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
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
          const SizedBox(height: 16),
          Container(
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage('images/banner_top.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          sectionHeader("Exclusive Offer"),
          const SizedBox(height: 10),
          horizontalProductList(filteredProducts.where((p) => exclusiveProducts.contains(p)).toList()),
          const SizedBox(height: 20),
          sectionHeader("Best Selling"),
          const SizedBox(height: 10),
          horizontalProductList(filteredProducts.where((p) => bestSellingProducts.contains(p)).toList()),
          sectionHeader("juice items"),
          const SizedBox(height: 10),
          horizontalProductList(filteredProducts.where((p) => juiceitems.contains(p)).toList()),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExplorePage(allProducts: allProducts),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favourite'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Account'),
        ],
      ),
    );
  }

  Widget sectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const Text("See all", style: TextStyle(color: Colors.green)),
      ],
    );
  }

  Widget horizontalProductList(List<Map<String, dynamic>> products) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return productCard(context, products[index]);
        },
      ),
    );
  }

  Widget productCard(BuildContext context, Map<String, dynamic> product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ProductDetailPage(product: product),
          ),
        );
      },
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Expanded(child: Image.asset(product['image'], height: 80)),
            const SizedBox(height: 8),
            Text(product['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(product['quantity'], style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("\$${product['price'].toStringAsFixed(2)}"),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailPage(product: product),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, color: Colors.white, size: 18),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}










