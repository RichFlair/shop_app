import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantiy;

  CartItem(
      {required this.id,
      required this.title,
      required this.price,
      required this.quantiy});
}

class Cart with ChangeNotifier {
  // ignore: prefer_final_fields
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  void addCartItems(String productId, String title, double price, int amount) {
    if (_items.containsKey(productId)) {
      // change quantity
      _items.update(
        productId,
        (value) => CartItem(
            id: value.id,
            title: value.title,
            price: value.price,
            quantiy: value.quantiy + 1),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
            id: DateTime.now().toString(),
            title: title,
            price: price,
            quantiy: 1),
      );
    }
  }
}
