import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/modules/product_management/presentation/bloc/product_bloc.dart';
import '../../domain/entities/product_entity.dart';
import '../pages/product_screen.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({super.key});

  @override
  State<AddProductForm> createState() => AddProductFormState();
}

class AddProductFormState extends State<AddProductForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _measurementController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _nameController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Name',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.multiline,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _measurementController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Measurement',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _priceController,
            decoration: const InputDecoration(
              labelText: 'Price',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 20,
          ),
          BlocConsumer<ProductBloc, ProductState>(listener: (_, state) {
            if (state is ProductListState) {
              //     Navigator.of(context).pushReplacement(MaterialPageRoute(
              //   builder: (context) => const ProductPage(),
              // ));
              Navigator.of(context).pop();
            }
          }, builder: (context, state) {
            if (state is Loadingstate) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  state is ErrorProductState
                      ? Padding(
                          padding: const EdgeInsets.all(20),
                          child: Center(
                            child: Text(state.message,
                                style: const TextStyle(color: Colors.red)),
                          ),
                        )
                      : const SizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_nameController.text != "" ||
                              _measurementController.text != "" ||
                              _priceController.text != "") {
                            BlocProvider.of<ProductBloc>(context).add(
                                ProductAddEvent(
                                    productEntity: ProductEntity(
                                        name: _nameController.text.trim(),
                                        measurement:
                                            _measurementController.text.trim(),
                                        price: _priceController.text.trim(),
                                        productNo: "")));
                          }
                        },
                        child: const Text(
                          'Add',
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  )
                ],
              );
            }
          }),
        ],
      ),
    );
  }
}
