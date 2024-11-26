import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_event.dart';
import 'cart_state.dart';
import '../../models/cart_item.dart';
import '../../repositories/cart_repository.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository = CartRepository();

  CartBloc() : super(CartLoaded(items: {})) {
    on<AddItemToCart>((event, emit) async {
      if (state is CartLoaded) {
        final updatedCart = Map<String, CartItem>.from((state as CartLoaded).items);

        if (updatedCart.containsKey(event.productId)) {
          updatedCart.update(
            event.productId,
                (existingItem) => CartItem(
              id: existingItem.id,
              productId: existingItem.productId,
              title: existingItem.title,
              quantity: existingItem.quantity + 1,
              price: existingItem.price,
            ),
          );
        } else {
          updatedCart[event.productId] = CartItem(
            id: DateTime.now().toString(),
            productId: event.productId,
            title: event.title,
            quantity: 1,
            price: event.price,
          );
        }


        print("Estado del carrito actualizado: $updatedCart");

        // Llamar al repositorio para guardar el producto en la base de datos
        await cartRepository.addItemToCart(event.productId, event.title, 1, event.price);


        emit(CartLoaded(items: updatedCart));
      }
    });
  }
}
