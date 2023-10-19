import 'package:flutter/material.dart';

import '../providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  // ignore: prefer_final_fields
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartproducts, double total) {
    _orders.add(
      OrderItem(
        id: DateTime.now().toString(),
        amount: total,
        products: cartproducts,
        dateTime: DateTime.now(),
      ),
    );
    notifyListeners();
  }
}
