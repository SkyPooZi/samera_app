import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'user_model.freezed.dart';

part 'user_model.g.dart';

@freezed
sealed class UserModel with _$UserModel {
  const factory UserModel({
    required String userId,
    required String name,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromEntities(UserEntity user) {
    return UserModel(
      userId: user.userId,
      name: user.name,
    );
  }

  static List<UserModel> fromJsonList(List data) {
    return data.map((e) => UserModel.fromJson(e)).toList();
  }
}
