import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isfavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isfavorite = false,
  });

  Future<void> changeFavorite(String id) async {
    var url =
        'https://shop-app-46835-default-rtdb.firebaseio.com/products/$id.json';

    isfavorite = !isfavorite;
    await http.patch(
      Uri.parse(url),
      body: json.encode({
        'isfavorite': isfavorite,
      }),
    );
    notifyListeners();
  }
}
