import 'package:flutter/material.dart';

class EditProdctScreen extends StatefulWidget {
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
    );
  }
}
