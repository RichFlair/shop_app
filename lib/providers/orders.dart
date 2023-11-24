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
  final String? authToken;
  Orders(
    this.authToken,
    this._orders,
  );

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartproducts, double total) async {
    final timestamp = DateTime.now();
    final url =
        'https://shop-app-46835-default-rtdb.firebaseio.com/orders.json?auth=$authToken';

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

  Future<void> fetchData() async {
    final url =
        'https://shop-app-46835-default-rtdb.firebaseio.com/orders.json?auth=$authToken';
    try {
      final response = await http.get(Uri.parse(url));
      if (json.decode(response.body) == null) {
        _orders = [];
        notifyListeners();
      } else {
        final fetchedOrder = json.decode(response.body) as Map<String, dynamic>;
        final List<OrderItem> loadedOrders = [];
        fetchedOrder.forEach((key, value) {
          List fetchedOrderProducts = json.decode(value['products']);
          List<CartItem> products = fetchedOrderProducts.map((e) {
            return CartItem(
                id: e['id'],
                title: e['title'],
                price: e['price'],
                quantiy: e['quantity']);
          }).toList();
          loadedOrders.add(OrderItem(
            id: key,
            amount: value['amount'],
            products: products,
            dateTime: DateTime.parse(value['dateTime']),
          ));
        });
        _orders = loadedOrders.reversed.toList();
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }
}
