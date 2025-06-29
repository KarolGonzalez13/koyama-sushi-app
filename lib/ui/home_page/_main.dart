import 'package:flutter/material.dart';
import 'package:koyama/database/home_page/_fetch.dart';
import 'package:koyama/database/home_page/category_preview.dart';
import 'package:koyama/ui/home_page/category_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<CategoryPreview>> categories;

  @override
  void initState() {
    super.initState();
    categories = fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: const TextSpan(
                      text: 'Koyama',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: 'Sushi',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  // Imagen del logo en la parte derecha superior
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
            ),

            FutureBuilder(
              future: categories,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children:
                        snapshot.data!
                            .map(
                              (category) => CategorySection(preview: category),
                            )
                            .toList(),
                  );
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                return const CircularProgressIndicator();
              },
            ),

            // Carrusel de categorías con imágenes
            SizedBox(
              height: 75,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: List.generate(6, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: _CategoryButton(index: index),
                  );
                }),
              ),
            ),
          ],
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
}

// Botón de categoría con imagen
class _CategoryButton extends StatefulWidget {
  final int index;
  const _CategoryButton({Key? key, required this.index}) : super(key: key);

  @override
  State<_CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<_CategoryButton> {
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
          SnackBar(content: Text('Categoría ${widget.index} seleccionada')),
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
          child: Image.asset(
            'assets/categoria_${widget.index}.png',
            width: 65,
            height: 65,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(
                Icons.image_not_supported,
                size: 48,
                color: Colors.white,
              );
            },
          ),
        ),
      ),
    );
  }
}
