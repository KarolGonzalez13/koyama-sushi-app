import 'package:koyama/database/home_page/dish_preview.dart';

class CategoryPreview {
  String name;
  String? description;
  List<DishPreview> dishes;

  CategoryPreview({required this.name, this.description, required this.dishes});
}
