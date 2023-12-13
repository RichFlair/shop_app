import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../screens/orders_screen.dart';
import '../screens/user_products_screen.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // SizedBox(
          //   width: double.infinity,
          //   child: DrawerHeader(
          //     padding: const EdgeInsets.only(top: 100, left: 130),
          //     decoration: BoxDecoration(
          //       color: Theme.of(context).colorScheme.primary,
          //     ),
          //     child: const Text('Menu'),
          //   ),
          // ),
          // const SizedBox(height: 10),
          AppBar(
            title: const Text('Hi Andrew'),
          ),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
            trailing: const Icon(Icons.forward),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Orders'),
            trailing: const Icon(Icons.forward),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(OrdersScreen.routName);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Products'),
            trailing: const Icon(Icons.forward),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(UserProductsScreen.routName);
            },
          ),
          const Divider(),
          const Spacer(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Logout'),
            trailing: const Icon(Icons.forward),
            onTap: () {
              Navigator.of(context).pop();
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
