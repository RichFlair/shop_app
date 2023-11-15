import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/drawer.dart';
import '../widgets/order_item.dart' as order;

class OrdersScreen extends StatelessWidget {
  static const routName = '/orers_screen';
  const OrdersScreen({super.key});

  // var _isInit = true;
  // var _isLoading = false;

  // @override
  // void didChangeDependencies() {
  //   if (_isInit) {
  //     setState(() {
  //       _isLoading = true;
  //     });
  //     Provider.of<Orders>(context).fetchData().then((_) => setState(() {
  //           _isLoading = false;
  //         }));
  //   }
  //   setState(() {
  //     _isInit = false;
  //   });
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    // print('loading');
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const DrawerWidget(),
      body: FutureBuilder(
        future:
            Provider.of<Orders>(context, listen: false).fetchData().then((_) {
          // print('Done!');
        }),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error occured'),
                );
              }
              return Consumer<Orders>(
                builder: (context, orderData, child) => orderData.orders.isEmpty
                    ? const Center(
                        child: Text(
                          'You have no orders!',
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) {
                          return order.OrderItem(
                              order: orderData.orders[index]);
                        },
                        itemCount: orderData.orders.length,
                      ),
              );
            }
          }
          throw e;
        },
      ),
    );
  }
}
