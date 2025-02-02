// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Task _$TaskFromJson(Map<String, dynamic> json) {
  return _Task.fromJson(json);
}

/// @nodoc
mixin _$Task {
  String get id => throw _privateConstructorUsedError;
  String get userID => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;
  String get aiTextResponse => throw _privateConstructorUsedError;
  List<String> get todoIDs => throw _privateConstructorUsedError;
  List<GroundingData> get groundings => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;
  @ClientCreatedTimestamp()
  DateTime? get createdDateTime => throw _privateConstructorUsedError;
  @ClientUpdatedTimestamp()
  DateTime? get updatedDateTime => throw _privateConstructorUsedError;
  @ServerCreatedTimestamp()
  DateTime? get serverCreatedDateTime => throw _privateConstructorUsedError;
  @ServerUpdatedTimestamp()
  DateTime? get serverUpdatedDateTime => throw _privateConstructorUsedError;

  /// Serializes this Task to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskCopyWith<Task> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskCopyWith<$Res> {
  factory $TaskCopyWith(Task value, $Res Function(Task) then) = _$TaskCopyWithImpl<$Res, Task>;
  @useResult
  $Res call(
      {String id,
      String userID,
      String question,
      String aiTextResponse,
      List<String> todoIDs,
      List<GroundingData> groundings,
      bool completed,
      @ClientCreatedTimestamp() DateTime? createdDateTime,
      @ClientUpdatedTimestamp() DateTime? updatedDateTime,
      @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
      @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime});
}

/// @nodoc
class _$TaskCopyWithImpl<$Res, $Val extends Task> implements $TaskCopyWith<$Res> {
  _$TaskCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userID = null,
    Object? question = null,
    Object? aiTextResponse = null,
    Object? todoIDs = null,
    Object? groundings = null,
    Object? completed = null,
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
      userID: null == userID
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      aiTextResponse: null == aiTextResponse
          ? _value.aiTextResponse
          : aiTextResponse // ignore: cast_nullable_to_non_nullable
              as String,
      todoIDs: null == todoIDs
          ? _value.todoIDs
          : todoIDs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      groundings: null == groundings
          ? _value.groundings
          : groundings // ignore: cast_nullable_to_non_nullable
              as List<GroundingData>,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
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
abstract class _$$TaskImplCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$TaskImplCopyWith(_$TaskImpl value, $Res Function(_$TaskImpl) then) = __$$TaskImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userID,
      String question,
      String aiTextResponse,
      List<String> todoIDs,
      List<GroundingData> groundings,
      bool completed,
      @ClientCreatedTimestamp() DateTime? createdDateTime,
      @ClientUpdatedTimestamp() DateTime? updatedDateTime,
      @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
      @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime});
}

/// @nodoc
class __$$TaskImplCopyWithImpl<$Res> extends _$TaskCopyWithImpl<$Res, _$TaskImpl> implements _$$TaskImplCopyWith<$Res> {
  __$$TaskImplCopyWithImpl(_$TaskImpl _value, $Res Function(_$TaskImpl) _then) : super(_value, _then);

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userID = null,
    Object? question = null,
    Object? aiTextResponse = null,
    Object? todoIDs = null,
    Object? groundings = null,
    Object? completed = null,
    Object? createdDateTime = freezed,
    Object? updatedDateTime = freezed,
    Object? serverCreatedDateTime = freezed,
    Object? serverUpdatedDateTime = freezed,
  }) {
    return _then(_$TaskImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userID: null == userID
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String,
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      aiTextResponse: null == aiTextResponse
          ? _value.aiTextResponse
          : aiTextResponse // ignore: cast_nullable_to_non_nullable
              as String,
      todoIDs: null == todoIDs
          ? _value._todoIDs
          : todoIDs // ignore: cast_nullable_to_non_nullable
              as List<String>,
      groundings: null == groundings
          ? _value._groundings
          : groundings // ignore: cast_nullable_to_non_nullable
              as List<GroundingData>,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
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
class _$TaskImpl extends _Task {
  const _$TaskImpl(
      {required this.id,
      required this.userID,
      required this.question,
      required this.aiTextResponse,
      required final List<String> todoIDs,
      required final List<GroundingData> groundings,
      required this.completed,
      @ClientCreatedTimestamp() this.createdDateTime,
      @ClientUpdatedTimestamp() this.updatedDateTime,
      @ServerCreatedTimestamp() this.serverCreatedDateTime,
      @ServerUpdatedTimestamp() this.serverUpdatedDateTime})
      : _todoIDs = todoIDs,
        _groundings = groundings,
        super._();

  factory _$TaskImpl.fromJson(Map<String, dynamic> json) => _$$TaskImplFromJson(json);

  @override
  final String id;
  @override
  final String userID;
  @override
  final String question;
  @override
  final String aiTextResponse;
  final List<String> _todoIDs;
  @override
  List<String> get todoIDs {
    if (_todoIDs is EqualUnmodifiableListView) return _todoIDs;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todoIDs);
  }

  final List<GroundingData> _groundings;
  @override
  List<GroundingData> get groundings {
    if (_groundings is EqualUnmodifiableListView) return _groundings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_groundings);
  }

  @override
  final bool completed;
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
    return 'Task(id: $id, userID: $userID, question: $question, aiTextResponse: $aiTextResponse, todoIDs: $todoIDs, groundings: $groundings, completed: $completed, createdDateTime: $createdDateTime, updatedDateTime: $updatedDateTime, serverCreatedDateTime: $serverCreatedDateTime, serverUpdatedDateTime: $serverUpdatedDateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userID, userID) || other.userID == userID) &&
            (identical(other.question, question) || other.question == question) &&
            (identical(other.aiTextResponse, aiTextResponse) || other.aiTextResponse == aiTextResponse) &&
            const DeepCollectionEquality().equals(other._todoIDs, _todoIDs) &&
            const DeepCollectionEquality().equals(other._groundings, _groundings) &&
            (identical(other.completed, completed) || other.completed == completed) &&
            (identical(other.createdDateTime, createdDateTime) || other.createdDateTime == createdDateTime) &&
            (identical(other.updatedDateTime, updatedDateTime) || other.updatedDateTime == updatedDateTime) &&
            (identical(other.serverCreatedDateTime, serverCreatedDateTime) || other.serverCreatedDateTime == serverCreatedDateTime) &&
            (identical(other.serverUpdatedDateTime, serverUpdatedDateTime) || other.serverUpdatedDateTime == serverUpdatedDateTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, userID, question, aiTextResponse, const DeepCollectionEquality().hash(_todoIDs),
      const DeepCollectionEquality().hash(_groundings), completed, createdDateTime, updatedDateTime, serverCreatedDateTime, serverUpdatedDateTime);

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith => __$$TaskImplCopyWithImpl<_$TaskImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskImplToJson(
      this,
    );
  }
}

abstract class _Task extends Task {
  const factory _Task(
      {required final String id,
      required final String userID,
      required final String question,
      required final String aiTextResponse,
      required final List<String> todoIDs,
      required final List<GroundingData> groundings,
      required final bool completed,
      @ClientCreatedTimestamp() final DateTime? createdDateTime,
      @ClientUpdatedTimestamp() final DateTime? updatedDateTime,
      @ServerCreatedTimestamp() final DateTime? serverCreatedDateTime,
      @ServerUpdatedTimestamp() final DateTime? serverUpdatedDateTime}) = _$TaskImpl;
  const _Task._() : super._();

  factory _Task.fromJson(Map<String, dynamic> json) = _$TaskImpl.fromJson;

  @override
  String get id;
  @override
  String get userID;
  @override
  String get question;
  @override
  String get aiTextResponse;
  @override
  List<String> get todoIDs;
  @override
  List<GroundingData> get groundings;
  @override
  bool get completed;
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

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskImplCopyWith<_$TaskImpl> get copyWith => throw _privateConstructorUsedError;
}
