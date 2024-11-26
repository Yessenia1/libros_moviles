import 'dart:convert';
import 'package:http/http.dart' as http;

class CartRepository {
  final String apiUrl = 'http://10.80.99.221:8082/api/cart';  // Usa tu IP local aquí
  // Cambia a la URL correcta

  // Esta función maneja la solicitud para agregar un producto al carrito en la base de datos
  Future<void> addItemToCart(String productId, String title, int quantity, double price) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'productId': productId,
          'title': title,
          'quantity': quantity,
          'price': price,
        }),
      );

      if (response.statusCode == 201) {
        print('Producto añadido al carrito en la base de datos');
      } else {
        print('Error al agregar producto al carrito: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al hacer la solicitud: $e');
    }
  }
}
