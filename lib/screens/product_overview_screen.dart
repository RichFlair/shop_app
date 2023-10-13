import 'package:flutter/material.dart';
import 'package:my_shop/models/product_model.dart';
import 'package:my_shop/widgets/product_item.dart';

class ProductOverviewScreen extends StatelessWidget {
  const ProductOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Product> loadedProducts = [
      Product(
        id: 'p1',
        title: 'Red Shirt',
        description: 'A red shirt - it is pretty red!',
        price: 29.99,
        imageUrl:
            'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
      ),
      Product(
        id: 'p2',
        title: 'Silver Imac',
        description: 'A silver Imac with a Magic keyboard.',
        price: 500.56,
        imageUrl:
            'https://cdn.pixabay.com/photo/2015/01/21/14/14/apple-606761_1280.jpg',
      ),
      Product(
        id: 'p4',
        title: 'Yellow Scarf',
        description: 'Warm and cozy - exactly what you need for the winter.',
        price: 75,
        imageUrl:
            'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
      ),
      Product(
        id: 'p3',
        title: 'Keybaord',
        description: 'A stylished computer keyboard.',
        price: 50.50,
        imageUrl:
            'https://images.pexels.com/photos/14008190/pexels-photo-14008190.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemBuilder: (context, index) {
          return ProductItem(
              id: loadedProducts[index].id,
              title: loadedProducts[index].title,
              description: loadedProducts[index].description,
              imageUrl: loadedProducts[index].imageUrl);
        },
        itemCount: loadedProducts.length,
      ),
    );
  }
}
