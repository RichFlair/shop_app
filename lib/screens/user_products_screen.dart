import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/drawer.dart';
import '../providers/products_provider.dart';
import '../widgets/user_products_item.dart';

class UserProductsScreen extends StatelessWidget {
  static const routName = '/user_product_screen';

  const UserProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      body: ListView.builder(
          itemBuilder: (context, index) => Column(
                children: [
                  UserProductsItem(
                    title: productData.items[index].title,
                    imageUrl: productData.items[index].imageUrl,
                  ),
                  const Divider(),
                ],
              ),
          itemCount: productData.items.length),
    );
  }
}
