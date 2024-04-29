part of 'products_cubit.dart';

abstract class ProductsState<T> {
  factory ProductsState.empty() = EmptyProductsState<T>;

  factory ProductsState.loading() = LoadingProductsState<T>;

  factory ProductsState.successAddProduct() = SuccessAddProductState<T>;

  factory ProductsState.successDeleteProduct() = SuccessDeleteProduct<T>;

  factory ProductsState.successUpdateProduct() = SuccessUpdateProduct<T>;

  factory ProductsState.loadedProductsByName(List<ProductModel> data) =
      LoadedProductsByName<T>;

  factory ProductsState.loadedAllProducts(List<ProductModel> data) =
      LoadedAllProducts<T>;

  factory ProductsState.error(ErrorModel error) = ErrorProductsState<T>;
}

class EmptyProductsState<T> implements ProductsState<T> {
  const EmptyProductsState();
}

class LoadingProductsState<T> implements ProductsState<T> {
  const LoadingProductsState();
}

class LoadedProductsByName<T> implements ProductsState<T> {
  final List<ProductModel> data;
  const LoadedProductsByName(this.data);
}

class LoadedAllProducts<T> implements ProductsState<T> {
  final List<ProductModel> data;
  const LoadedAllProducts(this.data);
}

class SuccessAddProductState<T> implements ProductsState<T> {
  const SuccessAddProductState();
}

class SuccessUpdateProduct<T> implements ProductsState<T> {
  const SuccessUpdateProduct();
}

class SuccessDeleteProduct<T> implements ProductsState<T> {
  const SuccessDeleteProduct();
}

class ErrorProductsState<T> implements ProductsState<T> {
  final ErrorModel error;
  ErrorProductsState(this.error);
}
