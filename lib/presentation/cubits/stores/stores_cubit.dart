import '../../../config/error_model.dart';
import '../../../config/result_class.dart';
import '../../../data/models/store_model.dart';
import '../../../data/repositories/stores_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'stores_state.dart';

class StoresCubit extends Cubit<StoresState> {
  final SotresRepository repository;
  StoresCubit({required this.repository}) : super(const EmptyStoresState());

  Future<void> addStore(
      {required storeName, required latitude, required longitude}) async {
    emit(const LoadingStoresState());
    await repository
        .addStore(
            storeName: storeName, latitude: latitude, longitude: longitude)
        .then((value) {
      if (value is SuccessState<bool>) {
        getStores();
        emit(const SuccessAddStoreState());
      } else if (value is ErrorState<bool>) {
        emit(ErrorStoresState(value.error));
      }
    });
  }

  Future<void> getStores() async {
    await repository.getStores().then((value) {
      if (value is SuccessState<List<StoreModel>>) {
        emit(LoadedStoresState(value.data));
      } else if (value is ErrorState<List<StoreModel>>) {
        emit(ErrorStoresState(value.error));
      }
    });
  }

  Future<void> getNearbyStores() async {
    await repository.getNearbyStores().then((value) {
      if (value is SuccessState<List<StoreModel>>) {
        emit(LoadedStoresState(value.data));
      } else if (value is ErrorState<List<StoreModel>>) {
        emit(ErrorStoresState(value.error));
      }
    });
  }
}
