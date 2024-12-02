import 'package:flutter/material.dart';

import 'product_entity.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}
class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> products = [];
  List<Product> filteredProducts = [];
  @override
  void initState() {
    super.initState();
// Simulating fetching 50,000+ products
    products = List.generate(
      50000,
          (index) => Product(
        id: 'id_$index',
        name: 'Product $index',
        category: index % 3 == 0 ? 'Electronics' : 'Fashion',
        price: (index % 100) * 10.0,
        rating: (index % 5) + 1.0,
        isAvailable: index % 2 == 0,
      ),
    );
    filteredProducts = products;
  }
  void filterProducts(String category, double minPrice, double maxPrice)
  {
    setState(() {
      filteredProducts = products.where((product) {
        return product.category == category &&
            product.price >= minPrice &&
            product.price <= maxPrice;
      }).toList();
    });
  }
  void sortProducts(String criteria) {
    setState(() {
      if (criteria == 'price') {
        filteredProducts.sort((a, b) => a.price.compareTo(b.price));
      } else if (criteria == 'rating') {
        filteredProducts.sort((a, b) => b.rating.compareTo(a.rating));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product List')),
      body: ListView.builder(
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          final product = filteredProducts[index];
          return ListTile(
            title: Text(product.name),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
          );
        },
      ),
    );
  }
}