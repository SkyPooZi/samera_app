import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/exception/network_exception.dart';
import '../../domain/repositories/auth_repository.dart';
import '../entities/user_entity.dart';

class Login {
  final AuthRepository authRepository;

  Login({required this.authRepository});

  Future<Either<NetworkException, UserEntity>> execute({
    required String email,
    required String password,
  }) async {
    try {
      return await authRepository.login(
        email: email,
        password: password,
      );
    } on DioException catch (e) {
      return Left(NetworkException.fromDioError(e));
    }
  }
}
