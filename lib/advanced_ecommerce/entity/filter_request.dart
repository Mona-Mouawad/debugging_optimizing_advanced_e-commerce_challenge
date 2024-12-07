import 'package:debugging_optimizing_ecommerce_challenge/advanced_ecommerce/entity/product_entity.dart';

class FilterRequest {
  List<Product> productInFilter;
  final String category;
  final double minPrice;
  final double maxPrice;
  final String sortCriteria;
  final bool isAvailable;
  FilterRequest({
    required this.productInFilter,
    required this.category,
    required this.minPrice,
    required this.maxPrice,
    required this.sortCriteria,
    required this.isAvailable,
  });

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'minPrice': minPrice,
      'maxPrice': maxPrice,
      'isAvailable': isAvailable,
      'sortCriteria': sortCriteria,
      'productInFilter': productInFilter.map((e) => e.toMap()).toList(),
    };
  }

  factory FilterRequest.formMap( Map<String, dynamic> prams){
    return FilterRequest(
      productInFilter:  (prams['productInFilter'] as List)
          .map((e) => Product.fromMap(e))
          .toList(),
      category: prams['category'],
      minPrice: prams['minPrice'],
      maxPrice: prams['maxPrice'],
      sortCriteria: prams['sortCriteria'],
      isAvailable: prams['isAvailable'],
    );
  }
}
