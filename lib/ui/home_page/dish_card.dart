import 'package:flutter/material.dart';
import 'package:koyama/database/home_page/dish_with_variations_preview.dart'
    as home_page;
import 'package:koyama/database/home_page/regular_dish_preview.dart';
import 'package:koyama/ui/_lib/defaultable_image.dart';

String titleCase(String input) {
  if (input.isEmpty) return input;
  return input[0].toUpperCase() + input.substring(1).toLowerCase();
}

Widget getDishTitle(dynamic dish) {
  if (dish is home_page.DishWithVariationsPreview) {
    return Column(
      children: [
        Text(
          dish.name,
          style: TextStyle(
            fontFamily: "Times New Roman",
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        getVariationsList(dish.variations!),
      ],
    );
  } else if (dish is RegularDishPreview) {
    return Row(
      children: [
        Text(
          dish.name,
          style: TextStyle(
            fontFamily: "Times New Roman",
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Text("\$${dish.price}"),
      ],
    );
  }
  throw Exception("Unknown dish type: ${dish.runtimeType}");
}

Widget getVariationsList(List<({String name, double price})> variations) {
  Map<double, List<String>> prices = {};

  for (var variation in variations) {
    if (prices[variation.price] == null) {
      prices[variation.price] = [];
    }
    prices[variation.price]!.add(variation.name);
  }

  return Column(
    children:
        prices.entries
            .map(
              (entry) => Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 70),
                    child: Text(
                      titleCase(entry.value.join(", ")),
                      style: TextStyle(fontSize: 10),
                    ),
                  ),
                  Spacer(),
                  Text("\$${entry.key}", style: TextStyle(fontSize: 12)),
                ],
              ),
            )
            .toList(),
  );
}

class DishCard extends StatelessWidget {
  dynamic preview;
  void Function(dynamic) showDishDetails;

  DishCard({super.key, required this.preview, required this.showDishDetails});

  @override
  Widget build(BuildContext context) {
    final double cardDimension = 150.0;

    return GestureDetector(
      onTap: () => showDishDetails(preview),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0),
        child: Container(
          width: cardDimension,
          height: cardDimension,
          decoration: BoxDecoration(
            color: const Color.fromARGB(120, 223, 223, 223),
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.hardEdge,
          child: Stack(
            children: [
              DefaultableImage(
                src: preview.imageUrl,
                defaultSrc: preview.defaultImageUrl,
                dimension: cardDimension,
                fit: BoxFit.cover,
                opacity: AlwaysStoppedAnimation(0.35),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                child: SizedBox(
                  width: cardDimension,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: getDishTitle(preview),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
