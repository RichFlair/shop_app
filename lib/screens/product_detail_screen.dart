import 'package:flutter/material.dart';
import 'package:my_shop/providers/products_provider.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routName = '/product_detail_screen';
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    final productData = Provider.of<Products>(
      context,
      listen: false,
    ).getProductId(productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(productData.title),
      ),
    );
  }
}
