import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/cart_screen.dart';
import '../providers/cart.dart';
import '../widgets/drawer.dart';
import '../widgets/cart_badge.dart';
import '../widgets/grid_view_builder.dart';
import '../providers/products_provider.dart';

enum SelectedValue {
  favorites,
  all,
}

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({super.key});

  @override
  State<ProductOverviewScreen> createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  var _showFavourites = false;
  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<Products>(context).fetchData();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // final productData = Provider.of<Products>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        // leading: Drawer(),
        title: const Text('MyShop'),
        actions: [
          Consumer<Cart>(
            builder: (_, cart, ch) {
              return CartBadge(
                value: cart.cartItemsCount.toString(),
                color: Theme.of(context).colorScheme.secondary,
                child: ch!,
              );
            },
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routName);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
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
      drawer: const DrawerWidget(),
      body: GridViewBuilder(showFav: _showFavourites),
    );
  }
}
