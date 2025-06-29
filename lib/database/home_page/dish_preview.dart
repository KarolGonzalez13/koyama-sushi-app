class DishPreview {
  String name;
  String? imageUrl;
  List<({String name, double price})>? variations;

  DishPreview({required this.name, this.imageUrl, this.variations});
}
