import '../../config/result_class.dart';
import '../datasources/stores_datasource.dart';
import '../models/store_model.dart';

class SotresRepository {
  final StoresDatasource _datasource;

  SotresRepository({required StoresDatasource datasource})
      : _datasource = datasource;
  Future<ResponseState<bool>> addStore(
      {required storeName, required latitude, required longitude}) async {
    final response = _datasource.addStore(
      storeName: storeName,
      latitude: latitude,
      longitude: longitude,
    );
    return response;
  }

  Future<ResponseState<List<StoreModel>>> getStores() async {
    final response = _datasource.getStores();
    return response;
  }

  Future<ResponseState<List<StoreModel>>> getNearbyStores() async {
    final response = _datasource.getNearbyStores();
    return response;
  }
}
