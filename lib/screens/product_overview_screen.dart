import 'package:flutter/material.dart';

import '../widgets/grid_view_builder.dart';

enum SelectedValue { favorites, all }

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({super.key});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavourites = false;
  @override
  Widget build(BuildContext context) {
    // final productData = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              setState(() {
                if (value == SelectedValue.favorites) {
                  // productData.showFavourites();
                  _showFavourites = true;
                } else {
                  // productData.showAll();
                  _showFavourites = false;
                }
              });
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
      body: GridViewBuilder(showFav: _showFavourites),
    );
  }
}
