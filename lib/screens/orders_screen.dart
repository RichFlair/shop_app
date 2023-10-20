import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/order_item.dart' as order;

class OrdersScreen extends StatelessWidget {
  static const routName = '/orers_screen';
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return orderData.orders.isEmpty
              ? const Text('You have no orders')
              : order.OrderItem(order: orderData.orders[index]);
        },
        itemCount: orderData.orders.length,
      ),
    );
  }
}
