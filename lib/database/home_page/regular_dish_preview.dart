class RegularDishPreview {
  String name;
  String? imageUrl;
  double price;
  String? description;
  String? defaultImageUrl; // New property

  RegularDishPreview({
    required this.name,
    this.imageUrl,
    required this.price,
    this.description,
    this.defaultImageUrl, // Initialize new property
  });

  @override
  String toString() {
    return 'RegularDishPreview(name: $name, imageUrl: $imageUrl, price: $price, description: $description, defaultImageUrl: $defaultImageUrl)';
  }
}
