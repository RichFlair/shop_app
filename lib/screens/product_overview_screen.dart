import 'package:flutter/material.dart';
import 'package:my_shop/providers/products_provider.dart';
import 'package:provider/provider.dart';

import '../widgets/grid_view_builder.dart';

enum SelectedValue { favorites, all }

class ProductOverviewScreen extends StatelessWidget {
  const ProductOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              if (value == SelectedValue.favorites) {
                productData.showFavourites();
              } else {
                productData.showAll();
              }
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) {
              return [
                const PopupMenuItem(
                  value: SelectedValue.favorites,
                  child: Text('Only Favorites'),
                ),
                const PopupMenuItem(
                  value: SelectedValue.all,
                  child: Text('Show All'),
                ),
              ];
            },
          )
        ],
      ),
      body: const GridViewBuilder(),
    );
  }
}