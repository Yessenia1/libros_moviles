// widgets/cart_item_widget.dart
import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  CartItemWidget({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(cartItem.title),
      subtitle: Text('Cantidad: ${cartItem.quantity} x \$${cartItem.price}'),
      trailing: Text('Total: \$${cartItem.quantity * cartItem.price}'),
    );
  }
}
