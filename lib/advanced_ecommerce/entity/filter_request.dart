import 'package:debugging_optimizing_ecommerce_challenge/advanced_ecommerce/entity/product_entity.dart';

class FilterRequest {
   List<Product> productInFilter;
  String category;
  double minPrice;
  double maxPrice;
  String sortCriteria;
  bool isAvailable;
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


}
