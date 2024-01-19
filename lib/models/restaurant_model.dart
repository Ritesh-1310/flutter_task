// Data model representing a restaurant
class Restaurant {
  // Properties to store restaurant information
  final String logo;
  final int id;
  final String name;
  final double rating;
  final String foodTypeEN;
  final int branchCount;

  // Constructor requiring logo, id, name, rating, foodTypeEN, and branchCount
  Restaurant({
    required this.logo,
    required this.id,
    required this.name,
    required this.rating,
    required this.foodTypeEN,
    required this.branchCount,
  });

  // Factory method to create a Restaurant instance from JSON
  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      logo: json['logo'],
      id: json['id'],
      name: json['name_en'],
      rating: json['rating'].toDouble(),
      foodTypeEN: json['foodTypeEN'],
      branchCount: json['branchCount'],
    );
  }
}
