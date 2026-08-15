import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_error.freezed.dart';

part 'network_error.g.dart';

@freezed
sealed class NetworkErrorModel with _$NetworkErrorModel {
  const factory NetworkErrorModel({
    int? statusCode,
    String? statusMessage,
  }) = _NetworkErrorModel;

  factory NetworkErrorModel.fromJson(Map<String, dynamic> json) =>
      _$NetworkErrorModelFromJson(json);
}
