class Product {
  final String image;
  final String name;
  final String unit;
  final double price;

  Product({
    required this.image,
    required this.name,
    required this.unit,
    required this.price,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      image: map['image'],
      name: map['name'],
      unit: map['unit'],
      price: double.tryParse(map['price'].toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'image': image,
      'name': name,
      'unit': unit,
      'price': price,
    };
  }
}
