import 'package:koyama/database/home_page/dish_with_variations_preview.dart';

class CategoryPreview {
  String name;
  String? description;
  String imageUrl; // New property
  // List<DishWithVariationsPreview | RegularDishPreview>
  List<dynamic> dishes;

  CategoryPreview({
    required this.name,
    this.description,
    required this.imageUrl, // Initialize new property
    required this.dishes,
  });

  @override
  String toString() {
    return 'CategoryPreview(name: $name, description: $description, imageUrl: $imageUrl, dishes: ${dishes.map((dish) => dish.toString()).toList()})';
  }
}
