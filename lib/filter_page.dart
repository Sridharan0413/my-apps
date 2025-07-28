import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  final List<Map<String, dynamic>> products;

  const FilterPage({super.key, required this.products});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  late final List<String> categories;
  late final List<String> brands;

  final Set<String> selectedCategories = {};
  final Set<String> selectedBrands = {};

  @override
  void initState() {
    super.initState();
    // Extract unique categories and brands from products
    categories = widget.products
        .map((product) => product['category']?.toString() ?? '')
        .toSet()
        .where((e) => e.isNotEmpty)
        .toList();

    brands = widget.products
        .map((product) => product['brand']?.toString() ?? '')
        .toSet()
        .where((e) => e.isNotEmpty)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.pink[50],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: const Text('Filters', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const SizedBox(height: 16),
            const Text('Categories',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...categories.map((category) => CheckboxListTile(
                  title: Text(category),
                  value: selectedCategories.contains(category),
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        selectedCategories.add(category);
                      } else {
                        selectedCategories.remove(category);
                      }
                    });
                  },
                )),
            const SizedBox(height: 16),
            const Text('Brands',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...brands.map((brand) => CheckboxListTile(
                  title: Text(brand),
                  value: selectedBrands.contains(brand),
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        selectedBrands.add(brand);
                      } else {
                        selectedBrands.remove(brand);
                      }
                    });
                  },
                )),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    selectedCategories.clear();
                    selectedBrands.clear();
                  });
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Clear All"),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'categories': selectedCategories,
                    'brands': selectedBrands,
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text("Apply Filter",
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

