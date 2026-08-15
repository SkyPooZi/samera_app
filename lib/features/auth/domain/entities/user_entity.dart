import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userId;
  final String name;

  const UserEntity({
    required this.userId,
    required this.name,
  });

  static var empty = const UserEntity(
    userId: '',
    name: '',
  );

  UserEntity copyWith({
    String? userId,
    String? name,
  }) =>
      UserEntity(
        userId: userId ?? this.userId,
        name: name ?? this.name,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        userId,
        name,
      ];
}
