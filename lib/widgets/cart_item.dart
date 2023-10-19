import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String title;
  final String productId;
  final double price;
  final int quantity;

  const CartItem({
    super.key,
    required this.id,
    required this.title,
    required this.productId,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    // final cart = Provider.of<Cart>(context);
    return Dismissible(
      key: ValueKey(id),
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeCartItem(productId);
      },
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.centerRight,
        color: Theme.of(context).colorScheme.error,
        margin: const EdgeInsets.symmetric(vertical: 7),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 30,
        ),
      ),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(child: Text('\$$price')),
          ),
          title: Text(title),
          subtitle: Text('Total: \$(${price * quantity})'),
          trailing: Text('${quantity}x'),
        ),
      ),
    );
  }
}
