import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../core/exception/network_exception.dart';
import '../../../domain/usecases/register.dart';

part 'register_event.dart';

part 'register_state.dart';

part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final Register register;

  RegisterBloc({
    required this.register,
  }) : super(const RegisterInitial()) {
    on<CreateAccountEvent>(
      (event, emit) async {
        emit(const RegisterLoading());

        final registerAPI = await register.execute(
          name: event.name,
          email: event.email,
          password: event.password,
        );

        registerAPI.fold(
          (failure) => emit(RegisterError(failure: failure)),
          (_) => emit(
            const RegisterLoaded(message: 'Register successfully'),
          ),
        );
      },
    );
  }
}
