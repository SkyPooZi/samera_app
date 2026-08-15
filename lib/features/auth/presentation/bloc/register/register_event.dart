part of 'register_bloc.dart';

@freezed
sealed class RegisterEvent with _$RegisterEvent {
  const factory RegisterEvent.createAccount({
    required String name,
    required String email,
    required String password,
  }) = CreateAccountEvent;
}
