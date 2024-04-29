import '../../config/result_class.dart';
import '../datasources/auth_datasource.dart';
import '../models/user_model.dart';

class AuthRepository {
  final AuthDataSource _dataSource;

  AuthRepository({required AuthDataSource dataSource})
      : _dataSource = dataSource;

  Future<ResponseState<UserModel>> signUp({
    required firstName,
    required lastName,
    required email,
    required password,
    required accountType,
  }) async {
    final userData = await _dataSource.signUp(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      accountType: accountType,
    );
    return userData;
  }

  Future<ResponseState<UserModel>> signIn(
      {required email, required password}) async {
    final userData = await _dataSource.signIn(email: email, password: password);
    return userData;
  }

  Future<ResponseState<bool>> signOut() async {
    final response = await _dataSource.signOut();
    return response;
  }

  Future<ResponseState<bool>> resetPassword({required email}) async {
    final response = await _dataSource.resetPassword(email: email);
    return response;
  }
}
