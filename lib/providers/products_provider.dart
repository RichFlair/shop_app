import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './product_model.dart';

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Silver Imac',
      description: 'A silver Imac with a Magic keyboard.',
      price: 500.56,
      imageUrl:
          'https://cdn.pixabay.com/photo/2015/01/21/14/14/apple-606761_1280.jpg',
    ),
    Product(
      id: 'p4',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 75,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Keybaord',
      description: 'A stylished computer keyboard.',
      price: 50.50,
      imageUrl:
          'https://images.pexels.com/photos/14008190/pexels-photo-14008190.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    ),
  ];

  // var isFavourites = false;

  Product getProductId(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  List<Product> get items {
    // if (isFavourites) {
    //   return _items.where((element) => element.isfavorite == true).toList();
    // }
    return [..._items];
  }

  List<Product> get favorites {
    return _items.where((element) => element.isfavorite == true).toList();
  }

  // void showFavourites() {
  //   isFavourites = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   isFavourites = false;
  //   notifyListeners();
  // }

  Future<void> addProduct(Product product) async {
    const url = 'https://shop-app-46835-default-rtdb.firebaseio.com/products';
    try {
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isfavorite': product.isfavorite,
        }),
      );
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  void updateProduct(String id, Product product) {
    final editingProductIndex =
        _items.indexWhere((element) => element.id == id);
    _items[editingProductIndex] = product;
    notifyListeners();
  }

  bool isAlreadyAdded(String id) {
    return _items.any((element) => element.id == id);
  }

  void deleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
