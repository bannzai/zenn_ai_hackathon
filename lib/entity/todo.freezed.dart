// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Todo _$TodoFromJson(Map<String, dynamic> json) {
  return _Todo.fromJson(json);
}

/// @nodoc
mixin _$Todo {
  String get id => throw _privateConstructorUsedError;
  String get taskID => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String? get supplement => throw _privateConstructorUsedError;
  String? get aiTextResponseMarkdown => throw _privateConstructorUsedError;
  List<GroundingData>? get groundings => throw _privateConstructorUsedError;
  AppLocation? get userLocation => throw _privateConstructorUsedError;
  List<AppLocation>? get locations => throw _privateConstructorUsedError;
  String? get locationsAITextResponse => throw _privateConstructorUsedError;
  List<GroundingData>? get locationsGroundings => throw _privateConstructorUsedError;
  int? get timeRequired => throw _privateConstructorUsedError;
  String? get timeRequiredAITextResponse => throw _privateConstructorUsedError;
  List<GroundingData>? get timeRequiredGroundings => throw _privateConstructorUsedError;
  int? get userTimeRequired => throw _privateConstructorUsedError;
  @NullableTimestampConverter()
  DateTime? get completedDateTime => throw _privateConstructorUsedError;
  @ClientCreatedTimestamp()
  DateTime? get createdDateTime => throw _privateConstructorUsedError;
  @ClientUpdatedTimestamp()
  DateTime? get updatedDateTime => throw _privateConstructorUsedError;
  @ServerCreatedTimestamp()
  DateTime? get serverCreatedDateTime => throw _privateConstructorUsedError;
  @ServerUpdatedTimestamp()
  DateTime? get serverUpdatedDateTime => throw _privateConstructorUsedError;

  /// Serializes this Todo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Todo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodoCopyWith<Todo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoCopyWith<$Res> {
  factory $TodoCopyWith(Todo value, $Res Function(Todo) then) = _$TodoCopyWithImpl<$Res, Todo>;
  @useResult
  $Res call(
      {String id,
      String taskID,
      String content,
      String? supplement,
      String? aiTextResponseMarkdown,
      List<GroundingData>? groundings,
      AppLocation? userLocation,
      List<AppLocation>? locations,
      String? locationsAITextResponse,
      List<GroundingData>? locationsGroundings,
      int? timeRequired,
      String? timeRequiredAITextResponse,
      List<GroundingData>? timeRequiredGroundings,
      int? userTimeRequired,
      @NullableTimestampConverter() DateTime? completedDateTime,
      @ClientCreatedTimestamp() DateTime? createdDateTime,
      @ClientUpdatedTimestamp() DateTime? updatedDateTime,
      @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
      @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime});

  $AppLocationCopyWith<$Res>? get userLocation;
}

/// @nodoc
class _$TodoCopyWithImpl<$Res, $Val extends Todo> implements $TodoCopyWith<$Res> {
  _$TodoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Todo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? taskID = null,
    Object? content = null,
    Object? supplement = freezed,
    Object? aiTextResponseMarkdown = freezed,
    Object? groundings = freezed,
    Object? userLocation = freezed,
    Object? locations = freezed,
    Object? locationsAITextResponse = freezed,
    Object? locationsGroundings = freezed,
    Object? timeRequired = freezed,
    Object? timeRequiredAITextResponse = freezed,
    Object? timeRequiredGroundings = freezed,
    Object? userTimeRequired = freezed,
    Object? completedDateTime = freezed,
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
      taskID: null == taskID
          ? _value.taskID
          : taskID // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      supplement: freezed == supplement
          ? _value.supplement
          : supplement // ignore: cast_nullable_to_non_nullable
              as String?,
      aiTextResponseMarkdown: freezed == aiTextResponseMarkdown
          ? _value.aiTextResponseMarkdown
          : aiTextResponseMarkdown // ignore: cast_nullable_to_non_nullable
              as String?,
      groundings: freezed == groundings
          ? _value.groundings
          : groundings // ignore: cast_nullable_to_non_nullable
              as List<GroundingData>?,
      userLocation: freezed == userLocation
          ? _value.userLocation
          : userLocation // ignore: cast_nullable_to_non_nullable
              as AppLocation?,
      locations: freezed == locations
          ? _value.locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<AppLocation>?,
      locationsAITextResponse: freezed == locationsAITextResponse
          ? _value.locationsAITextResponse
          : locationsAITextResponse // ignore: cast_nullable_to_non_nullable
              as String?,
      locationsGroundings: freezed == locationsGroundings
          ? _value.locationsGroundings
          : locationsGroundings // ignore: cast_nullable_to_non_nullable
              as List<GroundingData>?,
      timeRequired: freezed == timeRequired
          ? _value.timeRequired
          : timeRequired // ignore: cast_nullable_to_non_nullable
              as int?,
      timeRequiredAITextResponse: freezed == timeRequiredAITextResponse
          ? _value.timeRequiredAITextResponse
          : timeRequiredAITextResponse // ignore: cast_nullable_to_non_nullable
              as String?,
      timeRequiredGroundings: freezed == timeRequiredGroundings
          ? _value.timeRequiredGroundings
          : timeRequiredGroundings // ignore: cast_nullable_to_non_nullable
              as List<GroundingData>?,
      userTimeRequired: freezed == userTimeRequired
          ? _value.userTimeRequired
          : userTimeRequired // ignore: cast_nullable_to_non_nullable
              as int?,
      completedDateTime: freezed == completedDateTime
          ? _value.completedDateTime
          : completedDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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

  /// Create a copy of Todo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AppLocationCopyWith<$Res>? get userLocation {
    if (_value.userLocation == null) {
      return null;
    }

    return $AppLocationCopyWith<$Res>(_value.userLocation!, (value) {
      return _then(_value.copyWith(userLocation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TodoImplCopyWith<$Res> implements $TodoCopyWith<$Res> {
  factory _$$TodoImplCopyWith(_$TodoImpl value, $Res Function(_$TodoImpl) then) = __$$TodoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String taskID,
      String content,
      String? supplement,
      String? aiTextResponseMarkdown,
      List<GroundingData>? groundings,
      AppLocation? userLocation,
      List<AppLocation>? locations,
      String? locationsAITextResponse,
      List<GroundingData>? locationsGroundings,
      int? timeRequired,
      String? timeRequiredAITextResponse,
      List<GroundingData>? timeRequiredGroundings,
      int? userTimeRequired,
      @NullableTimestampConverter() DateTime? completedDateTime,
      @ClientCreatedTimestamp() DateTime? createdDateTime,
      @ClientUpdatedTimestamp() DateTime? updatedDateTime,
      @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
      @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime});

  @override
  $AppLocationCopyWith<$Res>? get userLocation;
}

/// @nodoc
class __$$TodoImplCopyWithImpl<$Res> extends _$TodoCopyWithImpl<$Res, _$TodoImpl> implements _$$TodoImplCopyWith<$Res> {
  __$$TodoImplCopyWithImpl(_$TodoImpl _value, $Res Function(_$TodoImpl) _then) : super(_value, _then);

  /// Create a copy of Todo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? taskID = null,
    Object? content = null,
    Object? supplement = freezed,
    Object? aiTextResponseMarkdown = freezed,
    Object? groundings = freezed,
    Object? userLocation = freezed,
    Object? locations = freezed,
    Object? locationsAITextResponse = freezed,
    Object? locationsGroundings = freezed,
    Object? timeRequired = freezed,
    Object? timeRequiredAITextResponse = freezed,
    Object? timeRequiredGroundings = freezed,
    Object? userTimeRequired = freezed,
    Object? completedDateTime = freezed,
    Object? createdDateTime = freezed,
    Object? updatedDateTime = freezed,
    Object? serverCreatedDateTime = freezed,
    Object? serverUpdatedDateTime = freezed,
  }) {
    return _then(_$TodoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      taskID: null == taskID
          ? _value.taskID
          : taskID // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      supplement: freezed == supplement
          ? _value.supplement
          : supplement // ignore: cast_nullable_to_non_nullable
              as String?,
      aiTextResponseMarkdown: freezed == aiTextResponseMarkdown
          ? _value.aiTextResponseMarkdown
          : aiTextResponseMarkdown // ignore: cast_nullable_to_non_nullable
              as String?,
      groundings: freezed == groundings
          ? _value._groundings
          : groundings // ignore: cast_nullable_to_non_nullable
              as List<GroundingData>?,
      userLocation: freezed == userLocation
          ? _value.userLocation
          : userLocation // ignore: cast_nullable_to_non_nullable
              as AppLocation?,
      locations: freezed == locations
          ? _value._locations
          : locations // ignore: cast_nullable_to_non_nullable
              as List<AppLocation>?,
      locationsAITextResponse: freezed == locationsAITextResponse
          ? _value.locationsAITextResponse
          : locationsAITextResponse // ignore: cast_nullable_to_non_nullable
              as String?,
      locationsGroundings: freezed == locationsGroundings
          ? _value._locationsGroundings
          : locationsGroundings // ignore: cast_nullable_to_non_nullable
              as List<GroundingData>?,
      timeRequired: freezed == timeRequired
          ? _value.timeRequired
          : timeRequired // ignore: cast_nullable_to_non_nullable
              as int?,
      timeRequiredAITextResponse: freezed == timeRequiredAITextResponse
          ? _value.timeRequiredAITextResponse
          : timeRequiredAITextResponse // ignore: cast_nullable_to_non_nullable
              as String?,
      timeRequiredGroundings: freezed == timeRequiredGroundings
          ? _value._timeRequiredGroundings
          : timeRequiredGroundings // ignore: cast_nullable_to_non_nullable
              as List<GroundingData>?,
      userTimeRequired: freezed == userTimeRequired
          ? _value.userTimeRequired
          : userTimeRequired // ignore: cast_nullable_to_non_nullable
              as int?,
      completedDateTime: freezed == completedDateTime
          ? _value.completedDateTime
          : completedDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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
class _$TodoImpl extends _Todo {
  const _$TodoImpl(
      {required this.id,
      required this.taskID,
      required this.content,
      required this.supplement,
      required this.aiTextResponseMarkdown,
      required final List<GroundingData>? groundings,
      this.userLocation,
      final List<AppLocation>? locations,
      this.locationsAITextResponse,
      final List<GroundingData>? locationsGroundings,
      this.timeRequired,
      this.timeRequiredAITextResponse,
      final List<GroundingData>? timeRequiredGroundings,
      this.userTimeRequired,
      @NullableTimestampConverter() this.completedDateTime,
      @ClientCreatedTimestamp() this.createdDateTime,
      @ClientUpdatedTimestamp() this.updatedDateTime,
      @ServerCreatedTimestamp() this.serverCreatedDateTime,
      @ServerUpdatedTimestamp() this.serverUpdatedDateTime})
      : _groundings = groundings,
        _locations = locations,
        _locationsGroundings = locationsGroundings,
        _timeRequiredGroundings = timeRequiredGroundings,
        super._();

  factory _$TodoImpl.fromJson(Map<String, dynamic> json) => _$$TodoImplFromJson(json);

  @override
  final String id;
  @override
  final String taskID;
  @override
  final String content;
  @override
  final String? supplement;
  @override
  final String? aiTextResponseMarkdown;
  final List<GroundingData>? _groundings;
  @override
  List<GroundingData>? get groundings {
    final value = _groundings;
    if (value == null) return null;
    if (_groundings is EqualUnmodifiableListView) return _groundings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final AppLocation? userLocation;
  final List<AppLocation>? _locations;
  @override
  List<AppLocation>? get locations {
    final value = _locations;
    if (value == null) return null;
    if (_locations is EqualUnmodifiableListView) return _locations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? locationsAITextResponse;
  final List<GroundingData>? _locationsGroundings;
  @override
  List<GroundingData>? get locationsGroundings {
    final value = _locationsGroundings;
    if (value == null) return null;
    if (_locationsGroundings is EqualUnmodifiableListView) return _locationsGroundings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? timeRequired;
  @override
  final String? timeRequiredAITextResponse;
  final List<GroundingData>? _timeRequiredGroundings;
  @override
  List<GroundingData>? get timeRequiredGroundings {
    final value = _timeRequiredGroundings;
    if (value == null) return null;
    if (_timeRequiredGroundings is EqualUnmodifiableListView) return _timeRequiredGroundings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final int? userTimeRequired;
  @override
  @NullableTimestampConverter()
  final DateTime? completedDateTime;
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
    return 'Todo(id: $id, taskID: $taskID, content: $content, supplement: $supplement, aiTextResponseMarkdown: $aiTextResponseMarkdown, groundings: $groundings, userLocation: $userLocation, locations: $locations, locationsAITextResponse: $locationsAITextResponse, locationsGroundings: $locationsGroundings, timeRequired: $timeRequired, timeRequiredAITextResponse: $timeRequiredAITextResponse, timeRequiredGroundings: $timeRequiredGroundings, userTimeRequired: $userTimeRequired, completedDateTime: $completedDateTime, createdDateTime: $createdDateTime, updatedDateTime: $updatedDateTime, serverCreatedDateTime: $serverCreatedDateTime, serverUpdatedDateTime: $serverUpdatedDateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.taskID, taskID) || other.taskID == taskID) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.supplement, supplement) || other.supplement == supplement) &&
            (identical(other.aiTextResponseMarkdown, aiTextResponseMarkdown) || other.aiTextResponseMarkdown == aiTextResponseMarkdown) &&
            const DeepCollectionEquality().equals(other._groundings, _groundings) &&
            (identical(other.userLocation, userLocation) || other.userLocation == userLocation) &&
            const DeepCollectionEquality().equals(other._locations, _locations) &&
            (identical(other.locationsAITextResponse, locationsAITextResponse) || other.locationsAITextResponse == locationsAITextResponse) &&
            const DeepCollectionEquality().equals(other._locationsGroundings, _locationsGroundings) &&
            (identical(other.timeRequired, timeRequired) || other.timeRequired == timeRequired) &&
            (identical(other.timeRequiredAITextResponse, timeRequiredAITextResponse) ||
                other.timeRequiredAITextResponse == timeRequiredAITextResponse) &&
            const DeepCollectionEquality().equals(other._timeRequiredGroundings, _timeRequiredGroundings) &&
            (identical(other.userTimeRequired, userTimeRequired) || other.userTimeRequired == userTimeRequired) &&
            (identical(other.completedDateTime, completedDateTime) || other.completedDateTime == completedDateTime) &&
            (identical(other.createdDateTime, createdDateTime) || other.createdDateTime == createdDateTime) &&
            (identical(other.updatedDateTime, updatedDateTime) || other.updatedDateTime == updatedDateTime) &&
            (identical(other.serverCreatedDateTime, serverCreatedDateTime) || other.serverCreatedDateTime == serverCreatedDateTime) &&
            (identical(other.serverUpdatedDateTime, serverUpdatedDateTime) || other.serverUpdatedDateTime == serverUpdatedDateTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        taskID,
        content,
        supplement,
        aiTextResponseMarkdown,
        const DeepCollectionEquality().hash(_groundings),
        userLocation,
        const DeepCollectionEquality().hash(_locations),
        locationsAITextResponse,
        const DeepCollectionEquality().hash(_locationsGroundings),
        timeRequired,
        timeRequiredAITextResponse,
        const DeepCollectionEquality().hash(_timeRequiredGroundings),
        userTimeRequired,
        completedDateTime,
        createdDateTime,
        updatedDateTime,
        serverCreatedDateTime,
        serverUpdatedDateTime
      ]);

  /// Create a copy of Todo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodoImplCopyWith<_$TodoImpl> get copyWith => __$$TodoImplCopyWithImpl<_$TodoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TodoImplToJson(
      this,
    );
  }
}

abstract class _Todo extends Todo {
  const factory _Todo(
      {required final String id,
      required final String taskID,
      required final String content,
      required final String? supplement,
      required final String? aiTextResponseMarkdown,
      required final List<GroundingData>? groundings,
      final AppLocation? userLocation,
      final List<AppLocation>? locations,
      final String? locationsAITextResponse,
      final List<GroundingData>? locationsGroundings,
      final int? timeRequired,
      final String? timeRequiredAITextResponse,
      final List<GroundingData>? timeRequiredGroundings,
      final int? userTimeRequired,
      @NullableTimestampConverter() final DateTime? completedDateTime,
      @ClientCreatedTimestamp() final DateTime? createdDateTime,
      @ClientUpdatedTimestamp() final DateTime? updatedDateTime,
      @ServerCreatedTimestamp() final DateTime? serverCreatedDateTime,
      @ServerUpdatedTimestamp() final DateTime? serverUpdatedDateTime}) = _$TodoImpl;
  const _Todo._() : super._();

  factory _Todo.fromJson(Map<String, dynamic> json) = _$TodoImpl.fromJson;

  @override
  String get id;
  @override
  String get taskID;
  @override
  String get content;
  @override
  String? get supplement;
  @override
  String? get aiTextResponseMarkdown;
  @override
  List<GroundingData>? get groundings;
  @override
  AppLocation? get userLocation;
  @override
  List<AppLocation>? get locations;
  @override
  String? get locationsAITextResponse;
  @override
  List<GroundingData>? get locationsGroundings;
  @override
  int? get timeRequired;
  @override
  String? get timeRequiredAITextResponse;
  @override
  List<GroundingData>? get timeRequiredGroundings;
  @override
  int? get userTimeRequired;
  @override
  @NullableTimestampConverter()
  DateTime? get completedDateTime;
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

  /// Create a copy of Todo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodoImplCopyWith<_$TodoImpl> get copyWith => throw _privateConstructorUsedError;
}
