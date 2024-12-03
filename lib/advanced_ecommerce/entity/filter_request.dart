class FilterRequest {
  // int productsLength;
  String category;
  double minPrice;
  double maxPrice;
  String sortCriteria;
  bool isAvailable;
  FilterRequest({
    // required this.productsLength,
    required this.category,
    required this.minPrice,
    required this.maxPrice,
    required this.sortCriteria,
    required this.isAvailable,
  });
}
