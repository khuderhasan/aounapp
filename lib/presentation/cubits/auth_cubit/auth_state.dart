part of 'auth_cubit.dart';

abstract class RegisterState<T> {
  factory RegisterState.empty() = EmptyRegisterState<T>;

  factory RegisterState.success(UserModel data) = SuccessRegisterState<T>;

  factory RegisterState.successSignOut() = SuccessSignOutRegisterState<T>;

  factory RegisterState.successResetPassword() = SuccessResetPassowrdState<T>;

  factory RegisterState.error(ErrorModel error) = ErrorRegisterState<T>;

  factory RegisterState.loading() = LoadingRegisterState<T>;
}

class EmptyRegisterState<T> implements RegisterState<T> {
  const EmptyRegisterState();
}

class LoadingRegisterState<T> implements RegisterState<T> {
  const LoadingRegisterState();
}

class SuccessRegisterState<T> implements RegisterState<T> {
  final UserModel data;

  const SuccessRegisterState(this.data);
}

class SuccessSignOutRegisterState<T> implements RegisterState<T> {
  const SuccessSignOutRegisterState();
}

class SuccessResetPassowrdState<T> implements RegisterState<T> {
  const SuccessResetPassowrdState();
}

class ErrorRegisterState<T> implements RegisterState<T> {
  final ErrorModel error;

  ErrorRegisterState(this.error);
}
