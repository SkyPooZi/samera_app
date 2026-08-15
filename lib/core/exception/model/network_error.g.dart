// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'network_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NetworkErrorModel _$NetworkErrorModelFromJson(Map<String, dynamic> json) =>
    _NetworkErrorModel(
      statusCode: (json['statusCode'] as num?)?.toInt(),
      statusMessage: json['statusMessage'] as String?,
    );

Map<String, dynamic> _$NetworkErrorModelToJson(_NetworkErrorModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'statusMessage': instance.statusMessage,
    };
