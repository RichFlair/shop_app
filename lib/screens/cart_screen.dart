import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

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
      body: Column(children: [
        Card(
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(children: [
              Text(
                'Total',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const Spacer(),
              Chip(
                label: Text(
                  cart.totalAmount.toString(),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('ORDER NOW'),
              ),
            ]),
          ),
        )
      ]),
    );
  }
}
