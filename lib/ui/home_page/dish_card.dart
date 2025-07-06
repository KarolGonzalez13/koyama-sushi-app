import 'package:flutter/material.dart';
import 'package:koyama/database/home_page/dish_with_variations_preview.dart'
    as home_page;
import 'package:koyama/database/home_page/regular_dish_preview.dart';

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

  DishCard({super.key, required this.preview});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: SizedBox.square(
        dimension: 150,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(120, 202, 202, 202),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              child: Image.network(
                preview.imageUrl ?? '',
                width: 150,
                height: 150,
                fit: BoxFit.cover,
                opacity: AlwaysStoppedAnimation(0.35),
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "assets/categoria_3.png",
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                    opacity: AlwaysStoppedAnimation(0.35),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              child: SizedBox(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: getDishTitle(preview),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
