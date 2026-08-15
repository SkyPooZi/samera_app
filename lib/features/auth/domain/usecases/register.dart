import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/exception/network_exception.dart';
import '../../domain/repositories/auth_repository.dart';

class Register {
  final AuthRepository authRepository;

  Register({required this.authRepository});

  Future<Either<NetworkException, String>> execute({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      return await authRepository.register(
        name: name,
        email: email,
        password: password,
      );
    } on DioException catch (e) {
      return Left(NetworkException.fromDioError(e));
    }
  }
}
