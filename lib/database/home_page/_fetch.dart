import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:koyama/database/collections.dart';
import 'package:koyama/database/home_page/category_preview.dart';
import 'package:koyama/database/home_page/dish_preview.dart';

Future<DishPreview> getDishPreview(
  QueryDocumentSnapshot<Map<String, dynamic>> dish,
) async {
  var variations = await dish.reference.collection("variations").get();
  var data = dish.data();
  return DishPreview(
    name: data["name"],
    imageUrl: data["imageUrl"],
    variations:
        variations.docs.map((variation) {
          var price = variation["price"];
          return (
            name: variation["name"] as String,
            price: price is int ? price.toDouble() : price as double,
          );
        }).toList(),
  );
}

Future<CategoryPreview> getDishCategory(
  QueryDocumentSnapshot<Map<String, dynamic>> category,
) async {
  var dishes =
      await Collections.dish()
          .where("category", isEqualTo: category.reference)
          .get();
  var dishPreviews = await Future.wait(
    dishes.docs.map(getDishPreview).toList(),
  );
  var dishCategory = CategoryPreview(
    name: category.data()["name"],
    dishes: dishPreviews,
    description: category.data()["description"],
  );
  return dishCategory;
}

Future<List<CategoryPreview>> fetch() async {
  var categories = await Collections.category().get();
  return await Future.wait(categories.docs.map(getDishCategory));
}
