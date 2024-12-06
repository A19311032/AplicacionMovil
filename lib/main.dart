import 'package:flutter/material.dart';
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



class CartPage extends StatelessWidget {
  final List<CartItem> cart;

  const CartPage({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double total =
        cart.fold(0, (sum, item) => sum + item.product.price * item.quantity);
    final formatCurrency = NumberFormat.currency(locale: 'es_MX', symbol: '\$');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];
                return ListTile(
                  leading: Image.network(item.product.imageUrl, height: 50),
                  title: Text(item.product.name),
                  subtitle: Text('Cantidad: ${item.quantity}'),
                  trailing: Text(
                      formatCurrency.format(item.product.price * item.quantity)),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Total: ${formatCurrency.format(total)}',
                style: const TextStyle(fontSize: 20)),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CheckoutPage()),
                );
              },
              child: const Text('Realizar Pago'),
            ),
          ),
        ],
      ),
    );
  }
}

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _securityCodeController = TextEditingController();
  final TextEditingController _cardHolderNameController = TextEditingController();
  String? _paymentError;

  void _processPayment() {
    if (_formKey.currentState!.validate()) {
      // Procesar pago
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (Route<dynamic> route) => false,
      );
    } else {
      setState(() {
        _paymentError = 'Por favor complete todos los campos correctamente.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Realizar Pago'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su nombre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _surnameController,
                decoration: const InputDecoration(labelText: 'Apellido'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su apellido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration:
                    const InputDecoration(labelText: 'Correo Electrónico'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su correo electrónico';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Dirección'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su dirección';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration:
                    const InputDecoration(labelText: 'Tipo de Tarjeta'),
                items: const [
                  DropdownMenuItem(value: 'credito', child: Text('Crédito')),
                  DropdownMenuItem(value: 'debito', child: Text('Débito')),
                ],
                validator: (value) {
                  if (value == null) {
                    return 'Por favor seleccione un tipo de tarjeta';
                  }
                  return null;
                },
                onChanged: (value) {},
              ),
              TextFormField(
                controller: _cardNumberController,
                decoration:
                    const InputDecoration(labelText: 'Número de Tarjeta'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese su número de tarjeta';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _expiryDateController,
                decoration:
                    const InputDecoration(labelText: 'Fecha de Vencimiento'),
                keyboardType: TextInputType.datetime,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la fecha de vencimiento';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _securityCodeController,
                decoration:
                    const InputDecoration(labelText: 'Código de Seguridad'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el código de seguridad';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cardHolderNameController,
                decoration: const InputDecoration(
                    labelText: 'Nombre del Beneficiario'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el nombre del beneficiario';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              if (_paymentError != null) ...[
                Text(
                  _paymentError!,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 20),
              ],
              ElevatedButton(
                onPressed: () {
                  _processPayment();
                },
                child: const Text('Realizar Pago'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}