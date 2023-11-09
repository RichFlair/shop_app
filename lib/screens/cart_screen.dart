import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/orders.dart';
import '../widgets/cart_item.dart' as display_cart_item;

class CartScreen extends StatelessWidget {
  static const routName = '/cart_screen';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Total',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                    ),
                  ),
                  OderButton(cart: cart),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return display_cart_item.CartItem(
                    id: cart.items.values.toList()[index].id,
                    title: cart.items.values.toList()[index].title,
                    productId: cart.items.keys.toList()[index],
                    price: cart.items.values.toList()[index].price,
                    quantity: cart.items.values.toList()[index].quantiy,
                  );
                },
                itemCount: cart.cartItemsCount),
          ),
        ],
      ),
    );
  }
}

class OderButton extends StatefulWidget {
  const OderButton({
    super.key,
    required this.cart,
  });

  final Cart cart;

  @override
  State<OderButton> createState() => _OderButtonState();
}

class _OderButtonState extends State<OderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.cart.cartItemsCount < 1
          ? null
          : () async {
              setState(() {
                _isLoading = true;
              });
              try {
                await Provider.of<Orders>(context, listen: false)
                    .addOrder(
                      widget.cart.items.values.toList(),
                      widget.cart.totalAmount,
                    )
                    .then(
                      (value) => widget.cart.clearCart(),
                    );
              } catch (e) {
                print(e);
              }
              setState(() {
                _isLoading = false;
              });
            },
      child: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : const Text('ORDER NOW'),
    );
  }
}
