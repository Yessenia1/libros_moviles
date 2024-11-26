import 'package:equatable/equatable.dart';

// Evento base para los eventos del carrito
abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

// Evento para agregar un artículo al carrito
class AddItemToCart extends CartEvent {
  final String productId;  // ID del producto
  final String title;      // Título del producto
  final double price;      // Precio del producto

  // Constructor
  const AddItemToCart({
    required this.productId,
    required this.title,
    required this.price,
  });

  @override
  List<Object> get props => [productId, title, price];
}
