import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:koyama/database/collections.dart';
import 'package:koyama/database/home_page/category_preview.dart';
import 'package:koyama/database/home_page/dish_with_variations_preview.dart';
import 'package:koyama/database/home_page/regular_dish_preview.dart';

Future<dynamic> getDishPreview(
  QueryDocumentSnapshot<Map<String, dynamic>> dish,
  String? defaultImageUrl, // Pass defaultImageUrl
) async {
  var variations = await dish.reference.collection("variations").get();
  var data = dish.data();

  if (data["type"] == "regular-dish") {
    return RegularDishPreview(
      name: data["name"],
      price: data["price"],
      imageUrl:
          data["imageUrl"] ??
          defaultImageUrl, // Use defaultImageUrl if imageUrl is null
      description: data["description"],
      defaultImageUrl: defaultImageUrl, // Pass defaultImageUrl
    );
  }

  return DishWithVariationsPreview(
    name: data["name"],
    imageUrl:
        data["imageUrl"] ??
        defaultImageUrl, // Use defaultImageUrl if imageUrl is null
    variations:
        variations.docs.map((variation) {
          var price = variation["price"];
          return (
            name: variation["name"] as String,
            price: price is int ? price.toDouble() : price as double,
          );
        }).toList(),
    description: data["description"],
    defaultImageUrl: defaultImageUrl, // Pass defaultImageUrl
  );
}

Future<CategoryPreview> getDishCategory(
  QueryDocumentSnapshot<Map<String, dynamic>> category,
) async {
  var dishes =
      await Collections.dish()
          .where("category", isEqualTo: category.reference)
          .get();
  var defaultDishImage = category.data()["defaultDishImage"];
  var dishPreviews = await Future.wait(
    dishes.docs.map((dish) => getDishPreview(dish, defaultDishImage)).toList(),
  );
  var dishCategory = CategoryPreview(
    name: category.data()["name"],
    description: category.data()["description"],
    imageUrl: category.data()["imageUrl"] ?? "",
    dishes: dishPreviews,
  );
  return dishCategory;
}

Future<List<CategoryPreview>> fetch() async {
  var categories = await Collections.category().get();
  var results = await Future.wait(categories.docs.map(getDishCategory)).then((
    value,
  ) {
    return value;
  });

  print("These are the results");
  print(results);

  return results;
}
