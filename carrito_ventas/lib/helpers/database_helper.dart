import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  // Private constructor
  DatabaseHelper._internal();

  // Get the database
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'carrito_ventas_db.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) {
      // Crear tablas aquí si no existen
      return db.execute('''
        CREATE TABLE products (
          id TEXT PRIMARY KEY,
          title TEXT,
          description TEXT,
          price REAL
        )
      ''');
    });
  }

  // Insertar un producto en la base de datos
  Future<void> insertProduct(Map<String, dynamic> product) async {
    final db = await database;
    await db.insert('products', product, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // Obtener todos los productos
  Future<List<Map<String, dynamic>>> getProducts() async {
    final db = await database;
    return await db.query('products');
  }

  // Eliminar un producto por su id
  Future<void> deleteProduct(String productId) async {
    final db = await database;
    await db.delete('products', where: 'id = ?', whereArgs: [productId]);
  }
}
