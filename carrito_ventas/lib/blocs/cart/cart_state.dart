// blocs/cart/cart_state.dart
import 'package:equatable/equatable.dart';
import '../../models/cart_item.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class CartLoaded extends CartState {
  final Map<String, CartItem> items;

  CartLoaded({required this.items});

  @override
  List<Object> get props => [items];
}
