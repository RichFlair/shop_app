import 'package:flutter/material.dart';
import 'package:my_shop/providers/cart.dart';
import 'package:my_shop/providers/orders.dart';
import 'package:my_shop/screens/cart_screen.dart';
import 'package:my_shop/screens/orders_screen.dart';
import 'package:provider/provider.dart';

import '/providers/products_provider.dart';
import '/screens/product_overview_screen.dart';
import '/screens/product_detail_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: myTheme,
        home: const ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routName: (context) =>
              const ProductDetailScreen(),
          CartScreen.routName: (context) => const CartScreen(),
          OrdersScreen.routName: (context) => const OrdersScreen(),
        },
      ),
    );
  }
}

// Theme
final myTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.purple,
    secondary: Colors.deepOrange,
  ),
  useMaterial3: true,
  fontFamily: 'Lato',
  textTheme: textTheme,
  appBarTheme: appBarTheme,
);
// AppBar theme
final appBarTheme = AppBarTheme(
  color: Colors.deepPurple,
  titleTextStyle: textTheme.titleLarge,
  foregroundColor: Colors.white,
);
// Text theme
const textTheme = TextTheme(
  titleLarge: TextStyle(
    fontFamily: 'Lato',
    // color: Colors.white,
    fontWeight: FontWeight.w700,
    fontSize: 22,
  ),
);
