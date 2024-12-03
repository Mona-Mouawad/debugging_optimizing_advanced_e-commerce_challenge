import 'package:flutter/material.dart';

import 'entity/product_entity.dart';

abstract class ProductCard {
  Widget buildCard(Product product);
}

class ElectronicsCard implements ProductCard {
  @override
  Widget buildCard(Product product) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      trailing: const Icon(Icons.electric_bolt),
    );
  }
}

class FashionCard implements ProductCard {
  @override
  Widget buildCard(Product product) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(product.rating.toString()),
          const Icon(Icons.star),
        ],
      ),
    );
  }
}

class GroceriesCard implements ProductCard {
  @override
  Widget buildCard(Product product) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
      trailing: Text(product.isAvailable ? 'Available' : 'Out of stock'),
    );
  }
}

class ProductCardFactory {
  static ProductCard createProductCard(String category) {
    if (category == 'Electronics') return ElectronicsCard();
    if (category == 'Fashion') return FashionCard();
    if (category == 'Groceries') return GroceriesCard();
    throw 'Can\'t create $category';
  }
}
