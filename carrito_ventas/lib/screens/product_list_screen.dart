import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_event.dart';
import '../models/product.dart';

class ProductListScreen extends StatelessWidget {
  final List<Product> products = [
    Product(
      id: 'p1',
      title: 'El Principito',
      description: 'Un libro clásico sobre la vida y la imaginación.',
      genre: 'Ficción/Infantil',
      synopsis: 'La historia de un pequeño príncipe que viaja por el universo.',
      price: 15.99,
      imageUrl: 'https://m.media-amazon.com/images/I/81a4kCNuH+L.jpg',
    ),
    Product(
      id: 'p2',
      title: '1984',
      description: 'Una visión distópica del futuro por George Orwell.',
      genre: 'Ciencia Ficción',
      synopsis: 'Un mundo totalitario donde la vigilancia lo es todo.',
      price: 12.99,
      imageUrl: 'https://m.media-amazon.com/images/I/71kxa1-0mfL.jpg',
    ),
    Product(
      id: 'p3',
      title: 'El Hobbit',
      description: 'La aventura épica escrita por J.R.R. Tolkien.',
      genre: 'Fantasía',
      synopsis: 'La aventura de Bilbo Bolsón para recuperar un tesoro robado.',
      price: 14.99,
      imageUrl: 'https://m.media-amazon.com/images/I/91b0C2YNSrL.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Orgullo y Prejuicio',
      description: 'La obra icónica de Jane Austen.',
      genre: 'Romance',
      synopsis: 'Una historia de amor y malentendidos en la Inglaterra del siglo XIX.',
      price: 10.99,
      imageUrl: 'https://m.media-amazon.com/images/I/81OthjkJBuL.jpg',
    ),
    Product(
      id: 'p5',
      title: 'El Alquimista',
      description: 'Un libro de inspiración de Paulo Coelho.',
      genre: 'Ficción/Inspiración',
      synopsis: 'La búsqueda de un pastor por su leyenda personal.',
      price: 13.99,
      imageUrl: 'https://m.media-amazon.com/images/I/71aFt4+OTOL.jpg',
    ),
    Product(
      id: 'p6',
      title: 'Los juegos del hambre',
      description: 'La novela distópica de Suzanne Collins.',
      genre: 'Ficción Juvenil',
      synopsis: 'Un brutal concurso donde la supervivencia es la clave.',
      price: 16.99,
      imageUrl: 'https://m.media-amazon.com/images/I/61JfGcL2ljL.jpg',
    ),
    Product(
      id: 'p7',
      title: 'Harry Potter y la piedra filosofal',
      description: 'El inicio de la saga mágica de J.K. Rowling.',
      genre: 'Fantasía Juvenil',
      synopsis: 'Un joven descubre que es un mago y asiste a Hogwarts.',
      price: 19.99,
      imageUrl: 'https://m.media-amazon.com/images/I/81YOuOGFCJL.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Libros'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.75,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        padding: EdgeInsets.all(10),
        itemCount: products.length,
        itemBuilder: (ctx, index) {
          final product = products[index];
          return GestureDetector(
            onTap: () => _showSynopsisDialog(context, product),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                      child: Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          product.genre,
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontStyle: FontStyle.italic,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '\$${product.price.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        context.read<CartBloc>().add(
                          AddItemToCart(
                            productId: product.id,
                            title: product.title,
                            price: product.price,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showSynopsisDialog(BuildContext context, Product product) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(product.title),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Género: ${product.genre}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                product.synopsis,
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}
