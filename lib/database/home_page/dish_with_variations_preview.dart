class DishWithVariationsPreview {
  String name;
  String? imageUrl;
  List<({String name, double price})> variations;
  String? description;
  String? defaultImageUrl;

  DishWithVariationsPreview({
    required this.name,
    this.imageUrl,
    required this.variations,
    this.description,
    this.defaultImageUrl,
  });

  @override
  String toString() {
    return 'DishWithVariationsPreview(name: $name, imageUrl: $imageUrl, variations: ${variations.map((v) => "{name: ${v.name}, price: ${v.price}}").toList()}, description: $description, defaultImageUrl: $defaultImageUrl)';
  }
}
