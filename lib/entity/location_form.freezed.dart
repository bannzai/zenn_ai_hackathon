// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_form.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LocationFormInfo _$LocationFormInfoFromJson(Map<String, dynamic> json) {
  return _LocationFormInfo.fromJson(json);
}

/// @nodoc
mixin _$LocationFormInfo {
  String get name => throw _privateConstructorUsedError;
  double? get latitude => throw _privateConstructorUsedError;
  double? get longitude => throw _privateConstructorUsedError;

  /// Serializes this LocationFormInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LocationFormInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LocationFormInfoCopyWith<LocationFormInfo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationFormInfoCopyWith<$Res> {
  factory $LocationFormInfoCopyWith(LocationFormInfo value, $Res Function(LocationFormInfo) then) =
      _$LocationFormInfoCopyWithImpl<$Res, LocationFormInfo>;
  @useResult
  $Res call({String name, double? latitude, double? longitude});
}

/// @nodoc
class _$LocationFormInfoCopyWithImpl<$Res, $Val extends LocationFormInfo> implements $LocationFormInfoCopyWith<$Res> {
  _$LocationFormInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LocationFormInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LocationFormInfoImplCopyWith<$Res> implements $LocationFormInfoCopyWith<$Res> {
  factory _$$LocationFormInfoImplCopyWith(_$LocationFormInfoImpl value, $Res Function(_$LocationFormInfoImpl) then) =
      __$$LocationFormInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, double? latitude, double? longitude});
}

/// @nodoc
class __$$LocationFormInfoImplCopyWithImpl<$Res> extends _$LocationFormInfoCopyWithImpl<$Res, _$LocationFormInfoImpl>
    implements _$$LocationFormInfoImplCopyWith<$Res> {
  __$$LocationFormInfoImplCopyWithImpl(_$LocationFormInfoImpl _value, $Res Function(_$LocationFormInfoImpl) _then) : super(_value, _then);

  /// Create a copy of LocationFormInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_$LocationFormInfoImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LocationFormInfoImpl implements _LocationFormInfo {
  const _$LocationFormInfoImpl({required this.name, required this.latitude, required this.longitude});

  factory _$LocationFormInfoImpl.fromJson(Map<String, dynamic> json) => _$$LocationFormInfoImplFromJson(json);

  @override
  final String name;
  @override
  final double? latitude;
  @override
  final double? longitude;

  @override
  String toString() {
    return 'LocationFormInfo(name: $name, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LocationFormInfoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.latitude, latitude) || other.latitude == latitude) &&
            (identical(other.longitude, longitude) || other.longitude == longitude));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, name, latitude, longitude);

  /// Create a copy of LocationFormInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LocationFormInfoImplCopyWith<_$LocationFormInfoImpl> get copyWith =>
      __$$LocationFormInfoImplCopyWithImpl<_$LocationFormInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LocationFormInfoImplToJson(
      this,
    );
  }
}

abstract class _LocationFormInfo implements LocationFormInfo {
  const factory _LocationFormInfo({required final String name, required final double? latitude, required final double? longitude}) =
      _$LocationFormInfoImpl;

  factory _LocationFormInfo.fromJson(Map<String, dynamic> json) = _$LocationFormInfoImpl.fromJson;

  @override
  String get name;
  @override
  double? get latitude;
  @override
  double? get longitude;

  /// Create a copy of LocationFormInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LocationFormInfoImplCopyWith<_$LocationFormInfoImpl> get copyWith => throw _privateConstructorUsedError;
}
