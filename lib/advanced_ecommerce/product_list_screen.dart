import 'dart:async';
import 'dart:developer';

import 'package:debugging_optimizing_ecommerce_challenge/advanced_ecommerce/product_widgets_factory.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

  import 'provider/filter_provider.dart';
import 'entity/product_entity.dart';
import 'filter_widget.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  late FilterAndSortProducts provider ;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider = Provider.of<FilterAndSortProducts>(context,listen: false)..generateLazyLoadingList()..scrollControllerListener();

    });
// Simulating fetching 50,000+ products
//     products = List.generate(
//       50000,
//           (index) => Product(
//         id: 'id_$index',
//         name: 'Product $index',
//         category: index % 3 == 0 ? 'Electronics' : 'Fashion',
//         price: (index % 100) * 10.0,
//         rating: (index % 5) + 1.0,
//         isAvailable: index % 2 == 0,
//       ),
//     );
//     filteredProducts = products;
  }

  // void filterProducts(String category, double minPrice, double maxPrice) {
  //   setState(() {
  //     filteredProducts = products.where((product) {
  //       return product.category == category &&
  //           product.price >= minPrice &&
  //           product.price <= maxPrice;
  //     }).toList();
  //   });
  // }
  //
  // void sortProducts(String criteria) {
  //   setState(() {
  //     if (criteria == 'price') {
  //       filteredProducts.sort((a, b) => a.price.compareTo(b.price));
  //     } else if (criteria == 'rating') {
  //       filteredProducts.sort((a, b) => b.rating.compareTo(a.rating));
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
        actions: [
          IconButton(
              onPressed: () {
                filterModalBottomSheet(context);
              },
              icon: const Icon(Icons.filter_list))
        ],
      ),
      body: Consumer<FilterAndSortProducts>(
        builder: (context, productProvider,_) {
          return ListView.builder(
            itemCount: productProvider.filteredProducts.length,
            controller: productProvider.scrollController,
            itemBuilder: (context, index) {
              if (index == provider.filteredProducts.length) {
                return provider.isLoading
                    ? const CircularProgressIndicator()
                    : const SizedBox.shrink();
              }
              final product = provider.filteredProducts[index];
              return ProductCardFactory.createProductCard(product.category)
                  .buildCard(product);
              // return ListTile(
              //   title: Text(product.name),
              //   subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
              // );
            },
          );
        }
      ),
    );
  }

  void filterModalBottomSheet(
    BuildContext context,
  ) {
    showModalBottomSheet(
        scrollControlDisabledMaxHeightRatio: 0.85,
        context: context,
        builder: (context) {
          return  FilterWidget(provider: provider,);
        });
  }

  @override
  dispose() {
    provider.scrollController.dispose();
    super.dispose();
  }
}
