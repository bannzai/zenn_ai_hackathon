// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'grounding_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GroundingData _$GroundingDataFromJson(Map<String, dynamic> json) {
  return _GroundingData.fromJson(json);
}

/// @nodoc
mixin _$GroundingData {
  String get id => throw _privateConstructorUsedError;
  int? get index => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  @ClientCreatedTimestamp()
  DateTime? get createdDateTime => throw _privateConstructorUsedError;
  @ClientUpdatedTimestamp()
  DateTime? get updatedDateTime => throw _privateConstructorUsedError;
  @ServerCreatedTimestamp()
  DateTime? get serverCreatedDateTime => throw _privateConstructorUsedError;
  @ServerUpdatedTimestamp()
  DateTime? get serverUpdatedDateTime => throw _privateConstructorUsedError;

  /// Serializes this GroundingData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GroundingData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GroundingDataCopyWith<GroundingData> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroundingDataCopyWith<$Res> {
  factory $GroundingDataCopyWith(GroundingData value, $Res Function(GroundingData) then) = _$GroundingDataCopyWithImpl<$Res, GroundingData>;
  @useResult
  $Res call(
      {String id,
      int? index,
      String? url,
      String? title,
      @ClientCreatedTimestamp() DateTime? createdDateTime,
      @ClientUpdatedTimestamp() DateTime? updatedDateTime,
      @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
      @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime});
}

/// @nodoc
class _$GroundingDataCopyWithImpl<$Res, $Val extends GroundingData> implements $GroundingDataCopyWith<$Res> {
  _$GroundingDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GroundingData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? index = freezed,
    Object? url = freezed,
    Object? title = freezed,
    Object? createdDateTime = freezed,
    Object? updatedDateTime = freezed,
    Object? serverCreatedDateTime = freezed,
    Object? serverUpdatedDateTime = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      createdDateTime: freezed == createdDateTime
          ? _value.createdDateTime
          : createdDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedDateTime: freezed == updatedDateTime
          ? _value.updatedDateTime
          : updatedDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      serverCreatedDateTime: freezed == serverCreatedDateTime
          ? _value.serverCreatedDateTime
          : serverCreatedDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      serverUpdatedDateTime: freezed == serverUpdatedDateTime
          ? _value.serverUpdatedDateTime
          : serverUpdatedDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GroundingDataImplCopyWith<$Res> implements $GroundingDataCopyWith<$Res> {
  factory _$$GroundingDataImplCopyWith(_$GroundingDataImpl value, $Res Function(_$GroundingDataImpl) then) = __$$GroundingDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      int? index,
      String? url,
      String? title,
      @ClientCreatedTimestamp() DateTime? createdDateTime,
      @ClientUpdatedTimestamp() DateTime? updatedDateTime,
      @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
      @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime});
}

/// @nodoc
class __$$GroundingDataImplCopyWithImpl<$Res> extends _$GroundingDataCopyWithImpl<$Res, _$GroundingDataImpl>
    implements _$$GroundingDataImplCopyWith<$Res> {
  __$$GroundingDataImplCopyWithImpl(_$GroundingDataImpl _value, $Res Function(_$GroundingDataImpl) _then) : super(_value, _then);

  /// Create a copy of GroundingData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? index = freezed,
    Object? url = freezed,
    Object? title = freezed,
    Object? createdDateTime = freezed,
    Object? updatedDateTime = freezed,
    Object? serverCreatedDateTime = freezed,
    Object? serverUpdatedDateTime = freezed,
  }) {
    return _then(_$GroundingDataImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      index: freezed == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      createdDateTime: freezed == createdDateTime
          ? _value.createdDateTime
          : createdDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedDateTime: freezed == updatedDateTime
          ? _value.updatedDateTime
          : updatedDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      serverCreatedDateTime: freezed == serverCreatedDateTime
          ? _value.serverCreatedDateTime
          : serverCreatedDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      serverUpdatedDateTime: freezed == serverUpdatedDateTime
          ? _value.serverUpdatedDateTime
          : serverUpdatedDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$GroundingDataImpl extends _GroundingData {
  const _$GroundingDataImpl(
      {required this.id,
      required this.index,
      required this.url,
      required this.title,
      @ClientCreatedTimestamp() this.createdDateTime,
      @ClientUpdatedTimestamp() this.updatedDateTime,
      @ServerCreatedTimestamp() this.serverCreatedDateTime,
      @ServerUpdatedTimestamp() this.serverUpdatedDateTime})
      : super._();

  factory _$GroundingDataImpl.fromJson(Map<String, dynamic> json) => _$$GroundingDataImplFromJson(json);

  @override
  final String id;
  @override
  final int? index;
  @override
  final String? url;
  @override
  final String? title;
  @override
  @ClientCreatedTimestamp()
  final DateTime? createdDateTime;
  @override
  @ClientUpdatedTimestamp()
  final DateTime? updatedDateTime;
  @override
  @ServerCreatedTimestamp()
  final DateTime? serverCreatedDateTime;
  @override
  @ServerUpdatedTimestamp()
  final DateTime? serverUpdatedDateTime;

  @override
  String toString() {
    return 'GroundingData(id: $id, index: $index, url: $url, title: $title, createdDateTime: $createdDateTime, updatedDateTime: $updatedDateTime, serverCreatedDateTime: $serverCreatedDateTime, serverUpdatedDateTime: $serverUpdatedDateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GroundingDataImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.index, index) || other.index == index) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.createdDateTime, createdDateTime) || other.createdDateTime == createdDateTime) &&
            (identical(other.updatedDateTime, updatedDateTime) || other.updatedDateTime == updatedDateTime) &&
            (identical(other.serverCreatedDateTime, serverCreatedDateTime) || other.serverCreatedDateTime == serverCreatedDateTime) &&
            (identical(other.serverUpdatedDateTime, serverUpdatedDateTime) || other.serverUpdatedDateTime == serverUpdatedDateTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, index, url, title, createdDateTime, updatedDateTime, serverCreatedDateTime, serverUpdatedDateTime);

  /// Create a copy of GroundingData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GroundingDataImplCopyWith<_$GroundingDataImpl> get copyWith => __$$GroundingDataImplCopyWithImpl<_$GroundingDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GroundingDataImplToJson(
      this,
    );
  }
}

abstract class _GroundingData extends GroundingData {
  const factory _GroundingData(
      {required final String id,
      required final int? index,
      required final String? url,
      required final String? title,
      @ClientCreatedTimestamp() final DateTime? createdDateTime,
      @ClientUpdatedTimestamp() final DateTime? updatedDateTime,
      @ServerCreatedTimestamp() final DateTime? serverCreatedDateTime,
      @ServerUpdatedTimestamp() final DateTime? serverUpdatedDateTime}) = _$GroundingDataImpl;
  const _GroundingData._() : super._();

  factory _GroundingData.fromJson(Map<String, dynamic> json) = _$GroundingDataImpl.fromJson;

  @override
  String get id;
  @override
  int? get index;
  @override
  String? get url;
  @override
  String? get title;
  @override
  @ClientCreatedTimestamp()
  DateTime? get createdDateTime;
  @override
  @ClientUpdatedTimestamp()
  DateTime? get updatedDateTime;
  @override
  @ServerCreatedTimestamp()
  DateTime? get serverCreatedDateTime;
  @override
  @ServerUpdatedTimestamp()
  DateTime? get serverUpdatedDateTime;

  /// Create a copy of GroundingData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GroundingDataImplCopyWith<_$GroundingDataImpl> get copyWith => throw _privateConstructorUsedError;
}
