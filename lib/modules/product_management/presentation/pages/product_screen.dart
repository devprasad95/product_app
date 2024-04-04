import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_app/modules/product_management/presentation/pages/add_products.dart';
import 'package:product_app/modules/product_management/presentation/pages/detail_screen.dart';
import '../bloc/product_bloc.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xffE4E4E4),
          appBar: PreferredSize(
              preferredSize:
                  const Size.fromHeight(100.0), 
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 500),
                      child: TextFormField(
                        controller: searchController,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          labelText: 'Search',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.multiline,
                        onChanged: (value) {
                          context
                              .read<ProductBloc>()
                              .add(ProductSearchEvent(word: value));
                        },
                      ),
                    ),
                  ),
                ],
              )),
          body: productList(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddProducts(),
                ),
              );
            },
            child: const Center(
              child: Icon(
                Icons.add,
              ),
            ),
          ),
        ),
      ),
    );
  }

  productList() {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (_, state) {
        if (state is Loadingstate) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ErrorProductState) {
          return const Center(child: Icon(Icons.refresh));
        }
        if (state is ProductListState) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => DetailsPage(
                                productModel: state.products[index]),
                          ),
                        );
                      },
                      child: Container(
                          decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 1.0,
                                ),
                              ],
                              color: Colors.white),
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                state.products[index].name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Row(children: [
                                    const SizedBox(width: 5),
                                    Text("Measurement: "
                                        "${state.products[index].measurement}"),
                                  ])),
                              const SizedBox(height: 10),
                              Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Row(children: [
                                    const SizedBox(width: 5),
                                    Text("Price: "
                                        "${state.products[index].price}"),
                                  ])),
                            ],
                          )));
                }),
          );
        }
        return const SizedBox();
      },
    );
  }
}
