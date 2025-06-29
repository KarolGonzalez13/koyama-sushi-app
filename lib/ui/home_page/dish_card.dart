import 'package:flutter/material.dart';
import 'package:koyama/database/home_page/dish_preview.dart' as home_page;

class DishCard extends StatelessWidget {
  home_page.DishPreview preview;

  DishCard({super.key, required this.preview});

  String getOptionsText(List<({String name, double price})> variations) {
    Map<double, List<String>> prices = {};

    for (var variation in variations) {
      if (prices[variation.price] == null) {
        prices[variation.price] = List.empty();
      }
      prices[variation.price]!.add(variation.name);
    }

    return prices.entries
        .map((entry) {
          return "${entry.value.join(" o ")}...${entry.key}";
        })
        .join("\n");
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Seleccionaste: ${preview.name}')),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          // Aquí puedes agregar una imagen de fondo si lo deseas
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              preview.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            if (preview.variations != null)
              Text(
                getOptionsText(preview.variations!),
                style: const TextStyle(color: Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}
