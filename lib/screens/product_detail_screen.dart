import 'package:flutter/material.dart';

import '/models/product_model.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routName = '/product_detail_screen';
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final productId = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
    );
  }
}
