import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/error_model.dart';
import '../../../config/result_class.dart';
import '../../../data/models/product_model.dart';
import '../../../data/repositories/products_repository.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  final ProductsRepository repository;
  ProductsCubit({required this.repository}) : super(const EmptyProductsState());
  Future<void> getProductsByName(
      {required productName, required storeId}) async {
    await repository
        .fetchProductsByName(productName: productName, storeId: storeId)
        .then((value) {
      if (value is SuccessState<List<ProductModel>>) {
        emit(LoadedProductsByName(value.data));
      } else if (value is ErrorState<List<ProductModel>>) {
        emit(ErrorProductsState(value.error));
      }
    });
  }

  Future<void> getAllProducts({required storeId}) async {
    emit(const LoadingProductsState());

    await repository.fetchAllProducts(storeId: storeId).then((value) {
      if (value is SuccessState<List<ProductModel>>) {
        emit(LoadedAllProducts(value.data));
      } else if (value is ErrorState<List<ProductModel>>) {
        emit(ErrorProductsState(value.error));
      }
    });
  }

  Future<void> addNewProduct(
      {required name,
      required image,
      required price,
      required location,
      required amount,
      required storeId}) async {
    emit(const LoadingProductsState());
    await repository
        .addNewProduct(
            name: name,
            price: price,
            amount: amount,
            location: location,
            image: image,
            storeId: storeId)
        .then((value) {
      if (value is SuccessState<bool>) {
        emit(const SuccessAddProductState());
        getAllProducts(storeId: storeId);
      } else if (value is ErrorState<bool>) {
        emit(ErrorProductsState(value.error));
      }
    });
  }

  Future<void> updateProduct(
      {required id,
      required name,
      required image,
      required price,
      required location,
      required amount,
      required storeId}) async {
    emit(const LoadingProductsState());
    await repository
        .updateProduct(
            id: id,
            name: name,
            price: price,
            amount: amount,
            location: location,
            image: image)
        .then((value) {
      if (value is SuccessState<bool>) {
        emit(const SuccessUpdateProduct());
        getAllProducts(storeId: storeId);
      } else if (value is ErrorState<bool>) {
        emit(ErrorProductsState(value.error));
      }
    });
  }

  Future<void> deleteProduct({required productId, required storeId}) async {
    await repository.deleteProduct(productId: productId).then((value) {
      if (value is SuccessState<bool>) {
        emit(const SuccessDeleteProduct());
        getAllProducts(storeId: storeId);
      } else if (value is ErrorState<bool>) {
        emit(ErrorProductsState(value.error));
      }
    });
  }
}
