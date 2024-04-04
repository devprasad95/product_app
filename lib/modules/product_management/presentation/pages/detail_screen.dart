import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/modules/product_management/presentation/pages/product_screen.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../data/models/product_model.dart';
import '../bloc/product_bloc.dart';

class DetailsPage extends StatefulWidget {
  final ProductModel productModel;
  const DetailsPage({super.key, required this.productModel});

  @override
  State<DetailsPage> createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
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
            backgroundColor: Colors.deepPurple,
            leading: IconButton(onPressed: () {
            Navigator.of(context).pop();    
            }, icon: const Icon(Icons.arrow_back),color: Colors.white,),
            title: const Text(
              'Product Details',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: productDetailWidget(),
        )));
  }

  productDetailWidget() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (_, state) {
        if (state is Loadingstate) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ErrorProductState) {
          return const Center(child: Icon(Icons.refresh));
        }
        if (state is ProductListState) {
          return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.productModel.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 5),
                  Text("Measurement: ${widget.productModel.measurement}"),
                  Text("Price: ${widget.productModel.price}"),
                  const SizedBox(height: 3),
                  Center(
                      child: QrImageView(
                    data: widget.productModel.name,
                    version: QrVersions.auto,
                    size: 180.0,
                  )),
                ],
              ));
        }
        return const SizedBox();
      },
    );
  }
}