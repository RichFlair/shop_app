import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  Future<void> addOrder(List<CartItem> cartproducts, double total) async {
    final timestamp = DateTime.now();
    const url =
        'https://shop-app-46835-default-rtdb.firebaseio.com/orders.json';

    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'amount': total,
          'products': jsonEncode(cartproducts),
          'dateTime': timestamp.toIso8601String(),
        }),
      );
      _orders.add(
        OrderItem(
          id: json.decode(response.body)['name'],
          amount: total,
          products: cartproducts,
          dateTime: timestamp,
        ),
      );
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
