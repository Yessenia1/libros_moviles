// screens/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/cart/cart_state.dart';
import '../models/cart_item.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de Compras'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            final cartItems = state.items.values.toList();
            final totalPrice = cartItems.fold(0.0, (sum, item) => sum + (item.price * item.quantity));

            if (cartItems.isEmpty) {
              return Center(child: Text('El carrito está vacío'));
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (ctx, index) {
                      final CartItem item = cartItems[index];
                      return ListTile(
                        title: Text(item.title),
                        subtitle: Text('Cantidad: ${item.quantity}'),
                        trailing: Text('\$${(item.price * item.quantity).toStringAsFixed(2)}'),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Total: \$${totalPrice.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Compra generada con éxito')),
                          );
                        },
                        child: Text('Generar Compra'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            // En caso de que no esté en estado `CartLoaded`, muestra un mensaje o maneja el error
            return Center(child: Text('No se pudieron cargar los productos del carrito.'));
          }
        },
      ),
    );
  }
}
