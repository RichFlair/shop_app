import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/drawer.dart';
import '../providers/products_provider.dart';
import '../widgets/user_products_item.dart';
import '../screens/edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routName = '/user_product_screen';

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchData(true);
  }

  const UserProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProdctScreen.routName);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const DrawerWidget(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: ListView.builder(
            itemBuilder: (context, index) => Column(
                  children: [
                    UserProductsItem(
                      id: productData.items[index].id,
                      title: productData.items[index].title,
                      imageUrl: productData.items[index].imageUrl,
                    ),
                    const Divider(),
                  ],
                ),
            itemCount: productData.items.length),
      ),
    );
  }
}
