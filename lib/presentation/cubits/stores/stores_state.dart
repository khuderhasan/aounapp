part of 'stores_cubit.dart';

abstract class StoresState<T> {
  factory StoresState.empty() = EmptyStoresState<T>;

  factory StoresState.loading() = LoadingStoresState<T>;

  factory StoresState.successAddProduct() = SuccessAddStoreState<T>;

  factory StoresState.loadedStores(List<StoreModel> data) =
      LoadedStoresState<T>;

  factory StoresState.error(ErrorModel error) = ErrorStoresState<T>;
}

class ErrorStoresState<T> implements StoresState<T> {
  final ErrorModel error;
  ErrorStoresState(this.error);
}

class EmptyStoresState<T> implements StoresState<T> {
  const EmptyStoresState();
}

class LoadingStoresState<T> implements StoresState<T> {
  const LoadingStoresState();
}

class LoadedStoresState<T> implements StoresState<T> {
  final List<StoreModel> data;
  const LoadedStoresState(this.data);
}

class SuccessAddStoreState<T> implements StoresState<T> {
  const SuccessAddStoreState();
}
