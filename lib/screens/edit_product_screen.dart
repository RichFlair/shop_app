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
  final _imageUrlController = TextEditingController();

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
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
                textInputAction: TextInputAction.next,
                focusNode: _priceFocusNode,
                onFieldSubmitted: (value) =>
                    FocusScope.of(context).requestFocus(_descriptionFocusNode),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Description'),
                keyboardType: TextInputType.multiline,
                focusNode: _descriptionFocusNode,
                maxLines: 3,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 30, right: 20),
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? const Center(child: Text('Input image URl'))
                        : FittedBox(
                            child: Image.network(
                              _imageUrlController.text,
                              fit: BoxFit.contain,
                            ),
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(labelText: 'Image URL'),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.url,
                      controller: _imageUrlController,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
