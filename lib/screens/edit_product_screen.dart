import 'package:flutter/material.dart';

class EditProdctScreen extends StatefulWidget {
  static const routName = '/edit_product_screen';
  const EditProdctScreen({super.key});

  @override
  State<EditProdctScreen> createState() => _EditProdctScreenState();
}

class _EditProdctScreenState extends State<EditProdctScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }

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
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(_priceFocusNode),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  label: Text('Price'),
                ),
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                keyboardType: TextInputType.multiline,
                maxLines: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
