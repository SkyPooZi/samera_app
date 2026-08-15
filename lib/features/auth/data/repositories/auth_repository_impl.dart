import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/exception/network_exception.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/remote/auth_remote_data_source.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({
    required this.authRemoteDataSource,
  });

  @override
  Future<Either<NetworkException, UserEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      UserModel resultModel = await authRemoteDataSource.login(
        email: email,
        password: password,
      );

      UserEntity result = UserEntity(
        userId: resultModel.userId,
        name: resultModel.name,
      );

      return Right(result);
    } on DioException catch (e) {
      return Left(NetworkException.fromDioError(e));
    }
  }

  @override
  Future<Either<NetworkException, String>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      String result = await authRemoteDataSource.register(
        name: name,
        email: email,
        password: password,
      );

      return Right(result);
    } on DioException catch (e) {
      return Left(NetworkException.fromDioError(e));
    }
  }
}
