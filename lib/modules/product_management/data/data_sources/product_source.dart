import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/error/exceptions.dart';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  getDocs();
  addProduct(ProductModel productModel);
  savedProductsList();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  int docId = 0;

  @override
  Future<int> getDocs() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("Product").get();
    var b = querySnapshot.docs.length;
    return docId = b + 1;
  }

  @override
  addProduct(ProductModel productModel) async {
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      return await firebaseFirestore
          .collection('Product')
          .doc(docId.toString())
          .set({
        "Name": productModel.name,
        "Measurement": productModel.measurement,
        "Price": productModel.price,
        "Product_no": docId,
      });
    } on FirebaseException {
      throw ServerException();
    }
  }

  @override
  Future savedProductsList() async {
    try {
      return await FirebaseFirestore.instance
          .collection('Product')
          .orderBy('Product_no', descending: false)
          .get();
    } on FirebaseException {
      throw ServerException();
    }
  }
}