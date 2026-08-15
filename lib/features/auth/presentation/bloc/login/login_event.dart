part of 'login_bloc.dart';

@freezed
sealed class LoginEvent with _$LoginEvent {
  const factory LoginEvent.loginAccount({
    required String email,
    required String password,
  }) = LoginAccountEvent;
}
