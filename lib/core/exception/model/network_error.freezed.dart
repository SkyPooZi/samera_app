// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NetworkErrorModel {

 int? get statusCode; String? get statusMessage;
/// Create a copy of NetworkErrorModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NetworkErrorModelCopyWith<NetworkErrorModel> get copyWith => _$NetworkErrorModelCopyWithImpl<NetworkErrorModel>(this as NetworkErrorModel, _$identity);

  /// Serializes this NetworkErrorModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NetworkErrorModel&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.statusMessage, statusMessage) || other.statusMessage == statusMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,statusCode,statusMessage);

@override
String toString() {
  return 'NetworkErrorModel(statusCode: $statusCode, statusMessage: $statusMessage)';
}


}

/// @nodoc
abstract mixin class $NetworkErrorModelCopyWith<$Res>  {
  factory $NetworkErrorModelCopyWith(NetworkErrorModel value, $Res Function(NetworkErrorModel) _then) = _$NetworkErrorModelCopyWithImpl;
@useResult
$Res call({
 int? statusCode, String? statusMessage
});




}
/// @nodoc
class _$NetworkErrorModelCopyWithImpl<$Res>
    implements $NetworkErrorModelCopyWith<$Res> {
  _$NetworkErrorModelCopyWithImpl(this._self, this._then);

  final NetworkErrorModel _self;
  final $Res Function(NetworkErrorModel) _then;

/// Create a copy of NetworkErrorModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? statusCode = freezed,Object? statusMessage = freezed,}) {
  return _then(_self.copyWith(
statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,statusMessage: freezed == statusMessage ? _self.statusMessage : statusMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NetworkErrorModel].
extension NetworkErrorModelPatterns on NetworkErrorModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NetworkErrorModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NetworkErrorModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NetworkErrorModel value)  $default,){
final _that = this;
switch (_that) {
case _NetworkErrorModel():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NetworkErrorModel value)?  $default,){
final _that = this;
switch (_that) {
case _NetworkErrorModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? statusCode,  String? statusMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NetworkErrorModel() when $default != null:
return $default(_that.statusCode,_that.statusMessage);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? statusCode,  String? statusMessage)  $default,) {final _that = this;
switch (_that) {
case _NetworkErrorModel():
return $default(_that.statusCode,_that.statusMessage);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? statusCode,  String? statusMessage)?  $default,) {final _that = this;
switch (_that) {
case _NetworkErrorModel() when $default != null:
return $default(_that.statusCode,_that.statusMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NetworkErrorModel implements NetworkErrorModel {
  const _NetworkErrorModel({this.statusCode, this.statusMessage});
  factory _NetworkErrorModel.fromJson(Map<String, dynamic> json) => _$NetworkErrorModelFromJson(json);

@override final  int? statusCode;
@override final  String? statusMessage;

/// Create a copy of NetworkErrorModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NetworkErrorModelCopyWith<_NetworkErrorModel> get copyWith => __$NetworkErrorModelCopyWithImpl<_NetworkErrorModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NetworkErrorModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NetworkErrorModel&&(identical(other.statusCode, statusCode) || other.statusCode == statusCode)&&(identical(other.statusMessage, statusMessage) || other.statusMessage == statusMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,statusCode,statusMessage);

@override
String toString() {
  return 'NetworkErrorModel(statusCode: $statusCode, statusMessage: $statusMessage)';
}


}

/// @nodoc
abstract mixin class _$NetworkErrorModelCopyWith<$Res> implements $NetworkErrorModelCopyWith<$Res> {
  factory _$NetworkErrorModelCopyWith(_NetworkErrorModel value, $Res Function(_NetworkErrorModel) _then) = __$NetworkErrorModelCopyWithImpl;
@override @useResult
$Res call({
 int? statusCode, String? statusMessage
});




}
/// @nodoc
class __$NetworkErrorModelCopyWithImpl<$Res>
    implements _$NetworkErrorModelCopyWith<$Res> {
  __$NetworkErrorModelCopyWithImpl(this._self, this._then);

  final _NetworkErrorModel _self;
  final $Res Function(_NetworkErrorModel) _then;

/// Create a copy of NetworkErrorModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? statusCode = freezed,Object? statusMessage = freezed,}) {
  return _then(_NetworkErrorModel(
statusCode: freezed == statusCode ? _self.statusCode : statusCode // ignore: cast_nullable_to_non_nullable
as int?,statusMessage: freezed == statusMessage ? _self.statusMessage : statusMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
