part of 'register_bloc.dart';

@freezed
class RegisterState with _$RegisterState {
  const factory RegisterState.initial() = RegisterInitial;

  const factory RegisterState.loading() = RegisterLoading;

  const factory RegisterState.error({
    required NetworkException failure,
  }) = RegisterError;

  const factory RegisterState.loaded({
    required String message,
  }) = RegisterLoaded;
}
