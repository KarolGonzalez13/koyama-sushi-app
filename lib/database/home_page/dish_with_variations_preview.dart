class DishWithVariationsPreview {
  String name;
  String? imageUrl;
  List<({String name, double price})>? variations;

  DishWithVariationsPreview({
    required this.name,
    this.imageUrl,
    this.variations,
  });

  @override
  String toString() {
    return 'DishPreview(name: $name, imageUrl: $imageUrl, variations: ${variations?.map((v) => "{name: ${v.name}, price: ${v.price}}").toList()})';
  }
}
