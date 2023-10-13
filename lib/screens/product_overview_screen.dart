import 'package:flutter/material.dart';

import '../widgets/grid_view_builder.dart';

class ProductOverviewScreen extends StatelessWidget {
  const ProductOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
      ),
      body: GridViewBuilder(),
    );
  }
}

