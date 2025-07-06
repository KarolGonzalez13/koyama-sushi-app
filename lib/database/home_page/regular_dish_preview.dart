class RegularDishPreview {
  String name;
  String? imageUrl;
  double price;

  RegularDishPreview({required this.name, this.imageUrl, required this.price});

  @override
  String toString() {
    return 'RegularDishPreview(name: $name, imageUrl: $imageUrl, price: $price)';
  }
}
