import 'package:flutter/material.dart';
import 'package:koyama/database/home_page/category_preview.dart';
import 'package:koyama/ui/home_page/dish_card.dart';

class CategorySection extends StatelessWidget {
  CategoryPreview preview;
  void Function(dynamic preview) showDishDetails;

  CategorySection({
    super.key,
    required this.preview,
    required this.showDishDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            preview.name,
            textAlign: TextAlign.start,
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
                preview.dishes
                    .map(
                      (dish) => DishCard(
                        preview: dish,
                        showDishDetails: showDishDetails,
                      ),
                    )
                    .toList(),
          ),
        ),
      ],
    );
  }
}
