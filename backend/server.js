const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Configuración de la conexión a MySQL
const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',  // Cambia esto si tu usuario no es 'root'
  password: '',  // Cambia esto si tienes una contraseña
  database: 'carrito_ventas_db',  // Nombre de tu base de datos
});

db.connect((err) => {
  if (err) {
    console.error('Error al conectar a la base de datos:', err);
  } else {
    console.log('Conectado a MySQL');
  }
});

// Ruta para agregar productos al carrito
app.post('/api/cart', (req, res) => {
  const { productId, title, quantity, price } = req.body;

  const query = 'INSERT INTO cart_items (product_id, title, quantity, price) VALUES (?, ?, ?, ?)';
  db.query(query, [productId, title, quantity, price], (err, result) => {
    if (err) {
      console.error('Error al agregar el producto al carrito:', err);
      res.status(400).json({ message: 'Error al agregar el producto al carrito', error: err });
    } else {
      res.status(201).json({ message: 'Producto añadido al carrito', data: result });
    }
  });
});

// Ruta para obtener los productos del carrito
app.get('/api/cart', (req, res) => {
  const query = 'SELECT * FROM cart_items';
  db.query(query, (err, results) => {
    if (err) {
      console.error('Error al obtener los productos del carrito:', err);
      res.status(400).json({ message: 'Error al obtener los productos', error: err });
    } else {
      res.status(200).json({ message: 'Productos obtenidos con éxito', data: results });
    }
  });
});

// Iniciar el servidor
const port = 8082;
app.listen(port, () => {
  console.log(`Servidor corriendo en http://localhost:${port}`);
});
