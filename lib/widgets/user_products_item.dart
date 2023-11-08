import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_product_screen.dart';
import '../providers/products_provider.dart';

class UserProductsItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  const UserProductsItem({
    super.key,
    required this.id,
    required this.title,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final scaffoldMessengerState = ScaffoldMessenger.of(context);
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProdctScreen.routName, arguments: id);
              },
              icon: Icon(
                Icons.edit,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            IconButton(
              onPressed: () async {
                try {
                  await Provider.of<Products>(context, listen: false)
                      .deleteProduct(id)
                      .then((value) => scaffoldMessengerState.showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Product successfully deleted',
                                textAlign: TextAlign.center,
                              ),
                              duration: Duration(seconds: 3),
                            ),
                          ));
                } catch (error) {
                  scaffoldMessengerState.showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Could not delete product',
                        textAlign: TextAlign.center,
                      ),
                      duration: Duration(seconds: 3),
                    ),
                  );
                }
              },
              icon: Icon(
                Icons.delete,
                color: Theme.of(context).colorScheme.error,
              ),
            )
          ],
        ),
      ),
    );
  }
}
