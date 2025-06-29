import 'package:flutter/material.dart';
import 'package:koyama/database/home_page/category_preview.dart' as home_page;
import 'package:koyama/ui/home_page/dish_card.dart';

class CategorySection extends StatelessWidget {
  home_page.CategoryPreview preview;

  CategorySection({super.key, required this.preview});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            preview.name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        Expanded(
          child: GridView.count(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.8,
            children:
                preview.dishes.map((dish) {
                  return DishCard(preview: dish);
                }).toList(),
          ),
        ),
      ],
    );
  }
}
