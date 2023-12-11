import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../providers/cart.dart';
import '../providers/product_model.dart';
import '/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  const ProductItem({
    super.key,
    // required this.id,
    // required this.title,
    // required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final productItem = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context);
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(12),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (context, product, _) => IconButton(
              onPressed: () async {
                try {
                  await product
                      .changeFavorite(
                    productItem.id,
                    auth.token,
                    auth.userId,
                  )
                      .then((value) {
                    if (productItem.isfavorite!) {
                      scaffoldMessenger.hideCurrentSnackBar();
                      scaffoldMessenger.showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Product added to favorites',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                    if (!productItem.isfavorite!) {
                      scaffoldMessenger.hideCurrentSnackBar();
                      scaffoldMessenger.showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Product removed from favorites',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                  });
                } catch (e) {
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      content: Text(
                        'An error occured',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
              icon: Icon(
                product.isfavorite! ? Icons.favorite : Icons.favorite_border,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
          title: Text(productItem.title),
          trailing: IconButton(
            onPressed: () {
              cart.addCartItems(
                productItem.id,
                productItem.title,
                productItem.price,
              );
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Item added to cart!'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                      label: 'UNDO',
                      onPressed: () {
                        cart.undoCartItem(productItem.id);
                      }),
                ),
              );
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
              ProductDetailScreen.routName,
              arguments: productItem.id),
          child: Image.network(
            productItem.imageUrl,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
