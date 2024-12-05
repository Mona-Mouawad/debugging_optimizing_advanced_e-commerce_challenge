class Product {
 final String id;
  final String name;
  final String category;
  final double price;
  final double rating;
  final bool isAvailable;
  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.isAvailable,
  });
 Map<String, dynamic> toMap() {
   return {
     'id': id,
     'name': name,
     'category': category,
     'price': price,
     'rating': rating,
     'isAvailable': isAvailable,
   };
 }
}