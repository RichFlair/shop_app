import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool? isfavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isfavorite,
  });

  Future<void> changeFavorite(
      String id, String? authToken, String? userId) async {
    isfavorite = !isfavorite!;
    notifyListeners();
    try {
      final url =
          'https://shop-app-46835-default-rtdb.firebaseio.com/userFavorites/$userId/$id.json?auth=$authToken';
      final response = await http.put(
        Uri.parse(url),
        body: json.encode(
          isfavorite,
        ),
      );
      // print(json.decode(response.body)['isfavorite']);
      if (response.statusCode >= 400) {
        isfavorite = !isfavorite!;
        notifyListeners();
        throw HttpException('Couldnt add to favorites');
      }
    } catch (e) {
      rethrow;
    }
  }
}
