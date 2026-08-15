import 'package:dartz/dartz.dart';
import '../../../../core/exception/network_exception.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<NetworkException, UserEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<NetworkException, String>> register({
    required String name,
    required String email,
    required String password,
  });
}
