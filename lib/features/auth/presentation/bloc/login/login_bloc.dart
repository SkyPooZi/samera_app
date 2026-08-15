import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../core/exception/network_exception.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/login.dart';

part 'login_event.dart';

part 'login_state.dart';

part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login login;

  LoginBloc({
    required this.login,
  }) : super(const LoginInitial()) {
    on<LoginAccountEvent>(
      (event, emit) async {
        emit(const LoginLoading());

        final loginAPI = await login.execute(
          email: event.email,
          password: event.password,
        );

        loginAPI.fold(
          (failure) => emit(LoginError(failure: failure)),
          (userEntity) => emit(
            LoginLoaded(
              userEntity: userEntity,
              message: 'Login successfully',
            ),
          ),
        );
      },
    );
  }
}
