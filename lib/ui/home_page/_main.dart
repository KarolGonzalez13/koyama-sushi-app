import 'package:flutter/material.dart';
import 'package:koyama/database/home_page/_fetch.dart';
import 'package:koyama/database/home_page/category_preview.dart';
import 'package:koyama/database/home_page/dish_with_variations_preview.dart';
import 'package:koyama/database/home_page/regular_dish_preview.dart';
import 'package:koyama/ui/_lib/defaultable_image.dart';
import 'package:koyama/ui/home_page/category_button.dart';
import 'package:koyama/ui/home_page/category_section.dart';
import 'package:koyama/ui/home_page/dish_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<CategoryPreview>> categories;

  int cartCount = 0;
  final List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    categories = fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: RichText(
          overflow: TextOverflow.visible,
          softWrap: true,
          textAlign: TextAlign.start,
          text: const TextSpan(
            text: 'Koyama',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(text: 'Sushi', style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        centerTitle: true,
        elevation: 0,
        actions: [
          Image.asset(
            'assets/logo.png',
            height: 70,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.image_not_supported,
                size: 72,
                color: Colors.grey,
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: FutureBuilder(
            future: categories,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              return ListView(
                scrollDirection: Axis.vertical,
                children: [
                  SizedBox(
                    height: 75,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      children:
                          snapshot.data!.map((category) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8.0,
                              ),
                              child: CategoryButton(
                                categoryId: category.name,
                                imageUrl: category.imageUrl,
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                  ...snapshot.data!.map(
                    (category) => CategorySection(
                      preview: category,
                      showDishDetails: _showDishDetails,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),

      // Menú inferior
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notificaciones',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
      ),
    );
  }

  void _showDishDetails(dynamic dishPreview) {
    int quantity = 1;

    String imageUrl = dishPreview.imageUrl;
    String name = dishPreview.name;
    String? selectedVariation;
    double? price;

    if (dishPreview is RegularDishPreview) {
      price = dishPreview.price;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 24,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    DefaultableImage(
                      src: imageUrl,
                      defaultSrc: dishPreview.defaultImageUrl,
                      dimension: 180,
                      fit: BoxFit.cover,
                      opacity: AlwaysStoppedAnimation(0.35),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Text(
                          selectedVariation != null
                              ? "${dishPreview.name} $selectedVariation"
                              : dishPreview.name,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 18),
                        if (price != null)
                          (Text(
                            "\$$price",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      ],
                    ),
                    if (dishPreview.description != null)
                      (Text(
                        dishPreview.description,
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      )),
                    const SizedBox(height: 16),

                    if (dishPreview is DishWithVariationsPreview)
                      ...([
                        Wrap(
                          spacing: 8,
                          children:
                              dishPreview.variations.map((variation) {
                                return ChoiceChip(
                                  label: RichText(
                                    text: TextSpan(
                                      text: variation.name,
                                      children:
                                          selectedVariation == variation.name
                                              ? []
                                              : [
                                                if (variation.price != null)
                                                  TextSpan(
                                                    text:
                                                        ' \$${variation.price}',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                              ],
                                    ),
                                  ),
                                  selected: selectedVariation == variation.name,
                                  onSelected: (selected) {
                                    if (selected) {
                                      setModalState(() {
                                        selectedVariation =
                                            selected ? variation.name : null;
                                        price = variation.price;
                                      });
                                    } else {
                                      setModalState(() {
                                        selectedVariation = null;
                                        price = null;
                                      });
                                    }
                                  },
                                );
                              }).toList(),
                        ),
                      ]),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed:
                              quantity > 1
                                  ? () => setModalState(() => quantity--)
                                  : null,
                        ),
                        Text('$quantity', style: const TextStyle(fontSize: 18)),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () => setModalState(() => quantity++),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
