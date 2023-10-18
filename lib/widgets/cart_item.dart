import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String title;
  final double price;
  final int quantity;

  const CartItem({
    super.key,
    required this.title,
    required this.price,
    required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: FittedBox(child: Text('\$$price')),
        ),
        title: Text(title),
        subtitle: Text('Total: \$(${price * quantity})'),
        trailing: Text('${quantity}x'),
      ),
    );
  }
}
