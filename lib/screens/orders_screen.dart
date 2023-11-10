import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart';
import '../widgets/drawer.dart';
import '../widgets/order_item.dart' as order;

class OrdersScreen extends StatefulWidget {
  static const routName = '/orers_screen';
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Orders>(context).fetchData().then((_) => setState(() {
            _isLoading = false;
          }));
    }
    setState(() {
      _isInit = false;
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: const DrawerWidget(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : orderData.orders.isEmpty
              ? const Center(
                  child: Text(
                    'You have no orders!',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return order.OrderItem(order: orderData.orders[index]);
                  },
                  itemCount: orderData.orders.length,
                ),
    );
  }
}
