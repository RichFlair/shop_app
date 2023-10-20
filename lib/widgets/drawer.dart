import 'package:flutter/material.dart';
import 'package:my_shop/screens/orders_screen.dart';

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
          const Divider()
        ],
      ),
    );
  }
}
