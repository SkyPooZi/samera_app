part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState.initial() = LoginInitial;

  const factory LoginState.loading() = LoginLoading;

  const factory LoginState.error({
    required NetworkException failure,
  }) = LoginError;

  const factory LoginState.loaded({
    required UserEntity userEntity,
    required String message,
  }) = LoginLoaded;
}
