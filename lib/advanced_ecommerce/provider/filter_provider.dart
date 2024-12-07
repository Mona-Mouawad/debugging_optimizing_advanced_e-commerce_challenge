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
  final int _pageSize =80;
  bool isLoading = false;
  FilterRequest? filterRequest;

  scrollControllerListener() => scrollController.addListener(() {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent * 0.8) {
          generateLazyLoadingList().then((_) async {


          });
        }
      });
  List<Product> moreProducts = [];

  Future<void> generateLazyLoadingList() async {
    Future.delayed(const Duration(milliseconds: 600), () async {
      moreProducts = [];
      if (isLoading) return;
      if (currentPage * _pageSize >= 50000) return;
      isLoading = true;
      moreProducts = (List.generate(
          _pageSize,
          (index) => Product(
                id: 'id_${currentPage * _pageSize + index}',
                name: 'Product ${currentPage * _pageSize + index}',
                category: (currentPage * _pageSize + index) % 3 == 0
                    ? 'Electronics'
                    : index % 3 == 0
                        ? 'Fashion'
                        : 'Groceries',
                price: ((currentPage * _pageSize + index) % 100) * 10.0,
                rating: ((currentPage * _pageSize + index) % 5) + 1.0,
                isAvailable: (currentPage * _pageSize + index) % 2 == 0,
              )));
      currentPage++;
      isLoading = false;
      products.addAll(moreProducts);
      if(filterRequest!=null) {
        filterRequest!.productInFilter = moreProducts;
        notifyListeners();
      }   await filterAndSortProduct();
    });
  }

  Future<void> filterAndSortProduct() async {
    log("moreProducts length is ${moreProducts.length}");
    if (filterRequest == null) {
      filteredProducts = products;
      log("filteredProducts length is ${filteredProducts.length}");
      notifyListeners();
    } else {
      // try {
      // filterRequest!.productInFilter = moreProducts;
      await compute(filterAndSort, filterRequest!.toMap())
          .then((productsFromFilter) {
        filteredProducts.addAll(productsFromFilter);
        log("filteredProducts length is ${filteredProducts.length}");
        notifyListeners();
      });
      // await compute(_filterAndSort, params);
      // } catch (e) {
      //   log("Error in filterAndSortProduct $e");
      // }
      // _filterAndSort(filterRequest!.toMap());
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
}

Future<List<Product>> filterAndSort(Map<String, dynamic> params) async {
  FilterRequest request = FilterRequest.formMap(params);

  List<Product> filtered = request.productInFilter.where((product) {
    return product.category == request.category &&
        product.price >= request.minPrice &&
        product.price <= request.maxPrice &&
        product.isAvailable == request.isAvailable;
  }).toList();

  if (request.sortCriteria == 'Price') {
    filtered.sort((a, b) => a.price.compareTo(b.price));
  } else if (request.sortCriteria == 'Rating') {
    filtered.sort((a, b) => b.rating.compareTo(a.rating));
  }
  return filtered;
}
