import '../../config/result_class.dart';
import '../datasources/products_datasource.dart';
import '../models/product_model.dart';

class ProductsRepository {
  final ProductsDatasource _dataSource;

  ProductsRepository({required ProductsDatasource dataSource})
      : _dataSource = dataSource;

  Future<ResponseState<List<ProductModel>>> fetchProductsByName(
      {required productName, required storeId}) async {
    final response = await _dataSource.fetchProductsByName(
        productName: productName, storeId: storeId);
    return response;
  }

  Future<ResponseState<List<ProductModel>>> fetchAllProducts(
      {required storeId}) async {
    final response = await _dataSource.fetchAllProducts(storeId: storeId);
    return response;
  }

  Future<ResponseState<bool>> addNewProduct(
      {required name,
      required price,
      required amount,
      required location,
      required image,
      required storeId}) async {
    final response = await _dataSource.addNewProduct(
        name: name,
        price: price,
        amount: amount,
        image: image,
        location: location,
        storeID: storeId);
    return response;
  }

  Future<ResponseState<bool>> deleteProduct({required productId}) async {
    final response = await _dataSource.deleteProduct(productId: productId);
    return response;
  }

  Future<ResponseState<bool>> updateProduct(
      {required id,
      required name,
      required amount,
      required price,
      required image,
      required location}) async {
    final response = await _dataSource.updateProduct(
        id: id,
        name: name,
        price: price,
        amount: amount,
        image: image,
        location: location);
    return response;
  }
}
