import 'package:flutter/material.dart';

class EditProdctScreen extends StatefulWidget {
  static const routName = '/edit_product_screen';
  const EditProdctScreen({super.key});

  @override
  State<EditProdctScreen> createState() => _EditProdctScreenState();
}

class _EditProdctScreenState extends State<EditProdctScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Products'),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
