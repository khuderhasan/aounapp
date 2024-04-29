import 'dart:io';

import '../../config/error_model.dart';
import '../../config/result_class.dart';
import '../models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProductsDatasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<ResponseState<List<ProductModel>>> fetchProductsByName(
      {required productName, required storeId}) async {
    List<ProductModel> products = [];
    try {
      await _firestore
          .collection('products')
          .where('name', isEqualTo: productName)
          .where('storeId', isEqualTo: storeId)
          .get()
          .then((value) {
        for (var element in value.docs) {
          products.add(ProductModel.fromMap(element.data()));
        }
      });
      return SuccessState(products);
    } on FirebaseException catch (e) {
      return ErrorState(ErrorModel(code: e.code, message: e.message!));
    }
  }

  Future<ResponseState<List<ProductModel>>> fetchAllProducts(
      {required storeId}) async {
    List<ProductModel> products = [];
    try {
      await _firestore
          .collection('products')
          .where('storeId', isEqualTo: storeId)
          .get()
          .then((value) {
        for (var element in value.docs) {
          products.add(ProductModel.fromMap(element.data()));
        }
      });
      return SuccessState(products);
    } on FirebaseException catch (e) {
      return ErrorState(ErrorModel(code: e.code, message: e.message!));
    }
  }

  Future<ResponseState<bool>> addNewProduct({
    required name,
    required price,
    required amount,
    required image,
    required location,
    required storeID,
  }) async {
    try {
      String id = '';
      await _firestore.collection('products').add({
        "name": name,
        "price": price,
        "amount": amount,
        "location": location,
        "storeId": storeID
      }).then((docRef) {
        id = docRef.id;
        docRef.update({
          'id': docRef.id,
        });
      });
      final reference =
          _firebaseStorage.ref().child('products_images').child("$id.jpg");
      final uploadImage = File(image.path);
      await reference.putFile(uploadImage);
      final url = await reference.getDownloadURL();
      await _firestore.collection('products').doc(id).update({
        "image": url,
      });
      return ResponseState.success(true);
    } on FirebaseException catch (e) {
      return ResponseState.error(ErrorModel(code: e.code, message: e.message!));
    }
  }

  Future<ResponseState<bool>> updateProduct(
      {required id,
      required name,
      required price,
      required amount,
      required image,
      required location}) async {
    try {
      if (image != null) {
        await _firebaseStorage
            .ref()
            .child('products_images')
            .child("$id.jpg")
            .delete();
        final reference =
            _firebaseStorage.ref().child('products_images').child("$id.jpg");
        final uploadImage = File(image.path);
        await reference.putFile(uploadImage);
        final url = await reference.getDownloadURL();
        await _firestore.collection('products').doc(id).update({
          "name": name,
          "price": price,
          "amount": amount,
          "location": location,
          "image": url,
        });
      } else if (image == null) {
        await _firestore.collection('products').doc(id).update({
          "name": name,
          "price": price,
          "amount": amount,
          "location": location,
        });
      }

      return ResponseState.success(true);
    } on FirebaseException catch (e) {
      return ResponseState.error(ErrorModel(code: e.code, message: e.message!));
    }
  }

  Future<ResponseState<bool>> deleteProduct({required String productId}) async {
    try {
      await _firestore.collection('products').doc(productId).delete();
      await _firebaseStorage
          .ref()
          .child('products_images')
          .child("$productId.jpg")
          .delete();
      return ResponseState.success(true);
    } on FirebaseException catch (e) {
      return ResponseState.error(ErrorModel(code: e.code, message: e.message!));
    }
  }
}
