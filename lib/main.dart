import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Product> products = [
    Product(
      name: 'Camisa Jordan',
      price: 4500.0,
      imageUrl:
          'https://images.stockx.com/images/Off-White-x-Jordan-T-shirt-Black.png?fit=fill&bg=FFFFFF&w=700&h=500&fm=webp&auto=compress&q=90&dpr=2&trim=color&updated_at=1636622356',
    ),
    Product(
      name: 'Jordan Dior',
      price: 250000.0,
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsTv67G0i4dNR4NzISX9zMPZyVSjPZVaZyPw&s',
    ),
    Product(
      name: 'Nike Dunk Low',
      price: 2500.0,
      imageUrl:
          'https://static.nike.com/a/images/t_PDP_1280_v1/f_auto,q_auto:eco/05856ac7-0129-4395-bd6e-2fe2669025fb/custom-nike-dunk-low-by-you-su24.png',
    ),
  ];

  final List<CartItem> cart = [];
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _addToCart(Product product, int quantity) {
    setState(() {
      cart.add(CartItem(product: product, quantity: quantity));
    });
  }

  String formatCurrency(double value) {
    final format = NumberFormat.currency(locale: 'es_MX', symbol: '\$');
    return format.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Punto de Venta'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartPage(cart: cart)),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (_image != null)
            Image.file(_image!, height: 200),
          ElevatedButton(
            onPressed: _pickImage,
            child: const Text('Tomar Foto del Producto'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductItem(
                  product: products[index],
                  onAddToCart: _addToCart,
                  formatCurrency: formatCurrency,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  final String imageUrl;

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}

class CartItem {
  final Product product;
  final int quantity;

  CartItem({
    required this.product,
    required this.quantity,
  });
}

class ProductItem extends StatefulWidget {
  final Product product;
  final void Function(Product, int) onAddToCart;
  final String Function(double) formatCurrency;

  const ProductItem({
    Key? key,
    required this.product,
    required this.onAddToCart,
    required this.formatCurrency,
  }) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Image.network(widget.product.imageUrl, height: 150),
            Text(widget.product.name, style: const TextStyle(fontSize: 20)),
            Text(widget.formatCurrency(widget.product.price),
                style: const TextStyle(fontSize: 16)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove),
                      onPressed: () {
                        if (_quantity > 1) {
                          setState(() {
                            _quantity--;
                          });
                        }
                      },
                    ),
                    Text('$_quantity'),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        setState(() {
                          _quantity++;
                        });
                      },
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.onAddToCart(widget.product, _quantity);
                  },
                  child: const Text('Agregar al carrito'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

