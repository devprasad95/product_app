import 'package:flutter/material.dart';
import 'package:product_app/modules/product_management/presentation/pages/product_screen.dart';

import '../widgets/add_product.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => AddProductsState();
}

class AddProductsState extends State<AddProducts> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (bool didPop) async {
        if (didPop) return;
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ProductPage(),
        ));
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Add Product",
            ),
          ),
          body: const Padding(
            padding: EdgeInsets.all(20.0),
            child: AddProductForm(),
          ),
        ),
      ),
    );
  }
}
