import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../entity/filter_request.dart';
import '../entity/product_entity.dart';

class FilterAndSortProductsProvider extends ChangeNotifier {
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
  List<Product> moreProducts = [];

  Future<void> generateLazyLoadingList() async {
    moreProducts = [];
    Future.delayed(const Duration(milliseconds: 500), () async {
      log('Loading page $currentPage');
      log('Loading  $isLoading');
      if (isLoading) return;
      if (currentPage * pageSize >= 50000) return;

      isLoading = true;
      currentPage++;
      notifyListeners();
      moreProducts = (List.generate(
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
      log("moreProducts length is ${moreProducts.length}");
      products.addAll(moreProducts);
      await filterAndSortProduct();
      notifyListeners();
    });
  }

  Future<void> filterAndSortProduct() async {
    log("moreProducts length is ${moreProducts.length}");
    log("filterRequest  is $filterRequest");
    if (filterRequest == null) {
      filteredProducts=products;
      log("filteredProducts length is ${filteredProducts.length}");

      notifyListeners();
    } else {
      await compute(_filterAndSort, filterRequest!.toMap());
      // final receivePort = ReceivePort();

      // await Isolate.spawn(
      //   _filterAndSort,
      //   [
      //     receivePort.sendPort,
      //     products,
      //     filterRequest!.category,
      //     filterRequest!.minPrice,
      //     filterRequest!.maxPrice,
      //     filterRequest!.sortCriteria
      //   ],
      // );

      // filteredProducts = await receivePort.first as List<Product>;
    }
  }

  void _filterAndSort(Map<String, dynamic> params ) {
    final category = params['category'];
    final minPrice = params['minPrice'];
    final maxPrice = params['maxPrice'];
    final sortCriteria = params['sortCriteria'];

    List<Product> filtered = params['productInFilter'].productInFilter.where((product) {
      return product.category == category &&
          product.price >= minPrice &&
          product.price <= maxPrice;
    }).toList();

    if (sortCriteria == 'Price') {
      filtered.sort((a, b) => a.price.compareTo(b.price));
    } else if (sortCriteria == 'Rating') {
      filtered.sort((a, b) => b.rating.compareTo(a.rating));
    }
    filteredProducts.addAll(filtered);
  }
}
