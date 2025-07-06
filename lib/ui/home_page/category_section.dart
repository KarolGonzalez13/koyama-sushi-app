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
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              fontFamily: "Times New Roman",
            ),
          ),
        ),
        if (preview.description != null) (Text(preview.description!)),

        SizedBox(
          width: double.infinity,
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children:
                preview.dishes.map((dish) => DishCard(preview: dish)).toList(),
          ),
        ),
      ],
    );
  }
}
