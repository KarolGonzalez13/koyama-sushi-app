import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                      return const Icon(Icons.image_not_supported, size: 72, color: Colors.grey);
                    },
                  ),
                ],
              ),
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

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text('Sopas',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),

            // Productos (Sopas)
            Expanded(
              child: GridView.count(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 0.8,
                children: [
                  _foodCard(context, 'Shoyu Ramen', 'Arrachera o Camarón', '\$145'),
                  _foodCard(context, 'Miso Ramen', 'Pollo, Cerdo o Res', '\$135'),
                ],
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
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notificaciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }

  Widget _foodCard(BuildContext context, String title, String description, String price) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Seleccionaste: $title')),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          // Aquí puedes agregar una imagen de fondo si lo deseas
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            Text(description,
                style: const TextStyle(
                  color: Colors.white70,
                )),
            Text(price,
                style: const TextStyle(
                  color: Colors.white,
                )),
          ],
        ),
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
              return const Icon(Icons.image_not_supported, size: 48, color: Colors.white);
            },
          ),
        ),
      ),
    );
  }
}
