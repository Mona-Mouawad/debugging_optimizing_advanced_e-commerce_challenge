import 'dart:developer';
import 'dart:isolate';


import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../entity/filter_request.dart';
import '../entity/product_entity.dart';

class FilterAndSortProducts extends ChangeNotifier {

    List<Product> products = [];
   List<Product> filteredProducts = [];
   final ScrollController scrollController = ScrollController();
   int currentPage = 0;
   int pageSize = 80;
   bool isLoading = false;
   FilterRequest? filterRequest;

  scrollControllerListener() => scrollController.addListener(() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent * 0.8) {
      generateLazyLoadingList();
    }
  });

    Future<void> generateLazyLoadingList() async {
    Future.delayed(const Duration(milliseconds: 500), () async {
      log('Loading page $currentPage');
      log('Loading  $isLoading');
      if (isLoading) return;
      if (currentPage * pageSize >= 50000) return;


        isLoading = true;
        currentPage++;
        notifyListeners();
        products.addAll(List.generate(
            pageSize,
                (index) => Product(
              id: 'id_${currentPage * pageSize + index}',
              name: 'Product ${currentPage * pageSize + index}',
              category: (currentPage * pageSize + index) % 3 == 0
                  ? 'Electronics'
                  : index % 3 == 0
                  ? 'Fashion'
                  : 'Groceries',
              price: ((currentPage * pageSize + index) % 100) * 10.0,
              rating: ((currentPage * pageSize + index) % 5) + 1.0,
              isAvailable: (currentPage * pageSize + index) % 2 == 0,
            )));
        isLoading = false;
      });

      await filterAndSortProducts();
 notifyListeners();

  }

   Future<void> filterAndSortProducts(
  ) async {
    if (filterRequest == null) {
      filteredProducts = products;
    } else {
      final receivePort = ReceivePort();

      await Isolate.spawn(
        _filterAndSort,
        [
          receivePort.sendPort,
          products,
          filterRequest!.category,
          filterRequest!.minPrice,
          filterRequest!.maxPrice,
          filterRequest!.sortCriteria
        ],
      );

      filteredProducts =  await receivePort.first as List<Product>;

    }
  }

   void _filterAndSort(List<dynamic> args) {
    SendPort sendPort = args[0];
    List<Product> products = args[1];
    String category = args[2];
    double minPrice = args[3];
    double maxPrice = args[4];
    String sortCriteria = args[5];

    List<Product> filtered = products.where((product) {
      return product.category == category &&
          product.price >= minPrice &&
          product.price <= maxPrice;
    }).toList();

    if (sortCriteria == 'Price') {
      filtered.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortCriteria == 'Rating') {
      filtered.sort((a, b) => b.rating.compareTo(a.rating));
    }

    sendPort.send(filtered);
  }
}
