import 'package:flutter/material.dart';
import 'package:koyama/ui/_lib/defaultable_image.dart';

class CategoryButton extends StatefulWidget {
  final String categoryId;
  final String imageUrl;
  const CategoryButton({
    Key? key,
    required this.categoryId,
    required this.imageUrl,
  }) : super(key: key);

  @override
  State<CategoryButton> createState() => CategoryButtonState();
}

class CategoryButtonState extends State<CategoryButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _pressed = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _pressed = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Categoría ${widget.categoryId} seleccionada'),
          ),
        );
      },
      onTapCancel: () {
        setState(() {
          _pressed = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        width: 60,
        decoration: BoxDecoration(
          color: _pressed ? Colors.redAccent.shade100 : Colors.red,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Image.network(
            widget.imageUrl,
            width: 65,
            height: 65,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
