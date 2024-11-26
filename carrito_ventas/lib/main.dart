import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/cart/cart_bloc.dart'; // Asegúrate de que el CartBloc está importado
import 'screens/product_list_screen.dart';
import 'screens/cart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Aquí estamos creando el CartBloc y poniéndolo a disposición de toda la aplicación
        BlocProvider(create: (_) => CartBloc()),
      ],
      child: MaterialApp(
        title: 'Carrito Ventas', // Título de la aplicación
        theme: ThemeData(primarySwatch: Colors.blue),
        // Pantalla principal con la lista de productos
        home: ProductListScreen(),
        routes: {
          // Ruta para el carrito de compras
          '/cart': (ctx) => CartScreen(),
        },
      ),
    );
  }
}
