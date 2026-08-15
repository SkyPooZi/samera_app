import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/network/api_end_point.dart';
import '../../../../../core/network/dio_instance.dart';
import '../../models/user_model.dart';
import 'auth_remote_data_source.dart';

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  DioInstance dioInstance = DioInstance();

  AuthRemoteDataSourceImpl();

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dioInstance.postRequest(
        endpoint: ApiEndPoint.baseUrlLogin,
        data: {
          "email": email,
          "password": password,
        },
      );

      Map<String, dynamic> data = response.data['loginResult'];

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('email', email);
      prefs.setString('token', data['token']);
      prefs.setString('userId', data['userId']);
      prefs.setString('name', data['name']);

      return UserModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await dioInstance.postRequest(
        endpoint: ApiEndPoint.baseUrlRegister,
        data: {
          "name": name,
          "email": email,
          "password": password,
        },
      );

      return response.data['message'];
    } catch (e) {
      rethrow;
    }
  }
}
