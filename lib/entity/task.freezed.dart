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
  switch (json['status']) {
    case 'prepared':
      return TaskPrepared.fromJson(json);
    case 'preparing':
      return TaskPreparing.fromJson(json);

    default:
      throw CheckedFromJsonException(json, 'status', 'Task', 'Invalid union type "${json['status']}"!');
  }
}

/// @nodoc
mixin _$Task {
  String get id => throw _privateConstructorUsedError;
  String get userID => throw _privateConstructorUsedError;
  String get question => throw _privateConstructorUsedError;
  String? get todosAITextResponseMarkdown => throw _privateConstructorUsedError;
  List<GroundingData>? get todosGroundings => throw _privateConstructorUsedError;
  String? get shortAnswer => throw _privateConstructorUsedError;
  String? get topic => throw _privateConstructorUsedError;
  String? get definitionAITextResponse => throw _privateConstructorUsedError;
  List<GroundingData>? get definitionGroundings => throw _privateConstructorUsedError;
  @ClientCreatedTimestamp()
  DateTime? get createdDateTime => throw _privateConstructorUsedError;
  @ClientUpdatedTimestamp()
  DateTime? get updatedDateTime => throw _privateConstructorUsedError;
  @ServerCreatedTimestamp()
  DateTime? get serverCreatedDateTime => throw _privateConstructorUsedError;
  @ServerUpdatedTimestamp()
  DateTime? get serverUpdatedDateTime => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String userID,
            String question,
            String todosAITextResponseMarkdown,
            List<GroundingData> todosGroundings,
            String shortAnswer,
            String topic,
            String definitionAITextResponse,
            List<GroundingData> definitionGroundings,
            List<AppLocation>? locations,
            String? locationsAITextResponse,
            List<GroundingData>? locationsGroundings,
            LocationFormInfo? userLocation,
            @NullableTimestampConverter() DateTime? preparedDateTime,
            @NullableTimestampConverter() DateTime? completedDateTime,
            @ClientCreatedTimestamp() DateTime? createdDateTime,
            @ClientUpdatedTimestamp() DateTime? updatedDateTime,
            @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
            @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime)
        prepared,
    required TResult Function(
            String id,
            String userID,
            String question,
            String? todosAITextResponseMarkdown,
            List<GroundingData>? todosGroundings,
            String? shortAnswer,
            String? topic,
            String? definitionAITextResponse,
            List<GroundingData>? definitionGroundings,
            @ClientCreatedTimestamp() DateTime? createdDateTime,
            @ClientUpdatedTimestamp() DateTime? updatedDateTime,
            @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
            @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime)
        preparing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String userID,
            String question,
            String todosAITextResponseMarkdown,
            List<GroundingData> todosGroundings,
            String shortAnswer,
            String topic,
            String definitionAITextResponse,
            List<GroundingData> definitionGroundings,
            List<AppLocation>? locations,
            String? locationsAITextResponse,
            List<GroundingData>? locationsGroundings,
            LocationFormInfo? userLocation,
            @NullableTimestampConverter() DateTime? preparedDateTime,
            @NullableTimestampConverter() DateTime? completedDateTime,
            @ClientCreatedTimestamp() DateTime? createdDateTime,
            @ClientUpdatedTimestamp() DateTime? updatedDateTime,
            @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
            @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime)?
        prepared,
    TResult? Function(
            String id,
            String userID,
            String question,
            String? todosAITextResponseMarkdown,
            List<GroundingData>? todosGroundings,
            String? shortAnswer,
            String? topic,
            String? definitionAITextResponse,
            List<GroundingData>? definitionGroundings,
            @ClientCreatedTimestamp() DateTime? createdDateTime,
            @ClientUpdatedTimestamp() DateTime? updatedDateTime,
            @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
            @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime)?
        preparing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String userID,
            String question,
            String todosAITextResponseMarkdown,
            List<GroundingData> todosGroundings,
            String shortAnswer,
            String topic,
            String definitionAITextResponse,
            List<GroundingData> definitionGroundings,
            List<AppLocation>? locations,
            String? locationsAITextResponse,
            List<GroundingData>? locationsGroundings,
            LocationFormInfo? userLocation,
            @NullableTimestampConverter() DateTime? preparedDateTime,
            @NullableTimestampConverter() DateTime? completedDateTime,
            @ClientCreatedTimestamp() DateTime? createdDateTime,
            @ClientUpdatedTimestamp() DateTime? updatedDateTime,
            @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
            @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime)?
        prepared,
    TResult Function(
            String id,
            String userID,
            String question,
            String? todosAITextResponseMarkdown,
            List<GroundingData>? todosGroundings,
            String? shortAnswer,
            String? topic,
            String? definitionAITextResponse,
            List<GroundingData>? definitionGroundings,
            @ClientCreatedTimestamp() DateTime? createdDateTime,
            @ClientUpdatedTimestamp() DateTime? updatedDateTime,
            @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
            @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime)?
        preparing,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskPrepared value) prepared,
    required TResult Function(TaskPreparing value) preparing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskPrepared value)? prepared,
    TResult? Function(TaskPreparing value)? preparing,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskPrepared value)? prepared,
    TResult Function(TaskPreparing value)? preparing,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

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
      String todosAITextResponseMarkdown,
      List<GroundingData> todosGroundings,
      String shortAnswer,
      String topic,
      String definitionAITextResponse,
      List<GroundingData> definitionGroundings,
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
    Object? todosAITextResponseMarkdown = null,
    Object? todosGroundings = null,
    Object? shortAnswer = null,
    Object? topic = null,
    Object? definitionAITextResponse = null,
    Object? definitionGroundings = null,
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
      todosAITextResponseMarkdown: null == todosAITextResponseMarkdown
          ? _value.todosAITextResponseMarkdown!
          : todosAITextResponseMarkdown // ignore: cast_nullable_to_non_nullable
              as String,
      todosGroundings: null == todosGroundings
          ? _value.todosGroundings!
          : todosGroundings // ignore: cast_nullable_to_non_nullable
              as List<GroundingData>,
      shortAnswer: null == shortAnswer
          ? _value.shortAnswer!
          : shortAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      topic: null == topic
          ? _value.topic!
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      definitionAITextResponse: null == definitionAITextResponse
          ? _value.definitionAITextResponse!
          : definitionAITextResponse // ignore: cast_nullable_to_non_nullable
              as String,
      definitionGroundings: null == definitionGroundings
          ? _value.definitionGroundings!
          : definitionGroundings // ignore: cast_nullable_to_non_nullable
              as List<GroundingData>,
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
abstract class _$$TaskPreparedImplCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$TaskPreparedImplCopyWith(_$TaskPreparedImpl value, $Res Function(_$TaskPreparedImpl) then) = __$$TaskPreparedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userID,
      String question,
      String todosAITextResponseMarkdown,
      List<GroundingData> todosGroundings,
      String shortAnswer,
      String topic,
      String definitionAITextResponse,
      List<GroundingData> definitionGroundings,
      List<AppLocation>? locations,
      String? locationsAITextResponse,
      List<GroundingData>? locationsGroundings,
      LocationFormInfo? userLocation,
      @NullableTimestampConverter() DateTime? preparedDateTime,
      @NullableTimestampConverter() DateTime? completedDateTime,
      @ClientCreatedTimestamp() DateTime? createdDateTime,
      @ClientUpdatedTimestamp() DateTime? updatedDateTime,
      @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
      @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime});

  $LocationFormInfoCopyWith<$Res>? get userLocation;
}

/// @nodoc
class __$$TaskPreparedImplCopyWithImpl<$Res> extends _$TaskCopyWithImpl<$Res, _$TaskPreparedImpl> implements _$$TaskPreparedImplCopyWith<$Res> {
  __$$TaskPreparedImplCopyWithImpl(_$TaskPreparedImpl _value, $Res Function(_$TaskPreparedImpl) _then) : super(_value, _then);

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userID = null,
    Object? question = null,
    Object? todosAITextResponseMarkdown = null,
    Object? todosGroundings = null,
    Object? shortAnswer = null,
    Object? topic = null,
    Object? definitionAITextResponse = null,
    Object? definitionGroundings = null,
    Object? locations = freezed,
    Object? locationsAITextResponse = freezed,
    Object? locationsGroundings = freezed,
    Object? userLocation = freezed,
    Object? preparedDateTime = freezed,
    Object? completedDateTime = freezed,
    Object? createdDateTime = freezed,
    Object? updatedDateTime = freezed,
    Object? serverCreatedDateTime = freezed,
    Object? serverUpdatedDateTime = freezed,
  }) {
    return _then(_$TaskPreparedImpl(
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
      todosAITextResponseMarkdown: null == todosAITextResponseMarkdown
          ? _value.todosAITextResponseMarkdown
          : todosAITextResponseMarkdown // ignore: cast_nullable_to_non_nullable
              as String,
      todosGroundings: null == todosGroundings
          ? _value._todosGroundings
          : todosGroundings // ignore: cast_nullable_to_non_nullable
              as List<GroundingData>,
      shortAnswer: null == shortAnswer
          ? _value.shortAnswer
          : shortAnswer // ignore: cast_nullable_to_non_nullable
              as String,
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      definitionAITextResponse: null == definitionAITextResponse
          ? _value.definitionAITextResponse
          : definitionAITextResponse // ignore: cast_nullable_to_non_nullable
              as String,
      definitionGroundings: null == definitionGroundings
          ? _value._definitionGroundings
          : definitionGroundings // ignore: cast_nullable_to_non_nullable
              as List<GroundingData>,
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
      userLocation: freezed == userLocation
          ? _value.userLocation
          : userLocation // ignore: cast_nullable_to_non_nullable
              as LocationFormInfo?,
      preparedDateTime: freezed == preparedDateTime
          ? _value.preparedDateTime
          : preparedDateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
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

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationFormInfoCopyWith<$Res>? get userLocation {
    if (_value.userLocation == null) {
      return null;
    }

    return $LocationFormInfoCopyWith<$Res>(_value.userLocation!, (value) {
      return _then(_value.copyWith(userLocation: value));
    });
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$TaskPreparedImpl extends TaskPrepared {
  const _$TaskPreparedImpl(
      {required this.id,
      required this.userID,
      required this.question,
      required this.todosAITextResponseMarkdown,
      required final List<GroundingData> todosGroundings,
      required this.shortAnswer,
      required this.topic,
      required this.definitionAITextResponse,
      required final List<GroundingData> definitionGroundings,
      final List<AppLocation>? locations,
      this.locationsAITextResponse,
      final List<GroundingData>? locationsGroundings,
      this.userLocation,
      @NullableTimestampConverter() required this.preparedDateTime,
      @NullableTimestampConverter() required this.completedDateTime,
      @ClientCreatedTimestamp() this.createdDateTime,
      @ClientUpdatedTimestamp() this.updatedDateTime,
      @ServerCreatedTimestamp() this.serverCreatedDateTime,
      @ServerUpdatedTimestamp() this.serverUpdatedDateTime,
      final String? $type})
      : _todosGroundings = todosGroundings,
        _definitionGroundings = definitionGroundings,
        _locations = locations,
        _locationsGroundings = locationsGroundings,
        $type = $type ?? 'prepared',
        super._();

  factory _$TaskPreparedImpl.fromJson(Map<String, dynamic> json) => _$$TaskPreparedImplFromJson(json);

  @override
  final String id;
  @override
  final String userID;
  @override
  final String question;
  @override
  final String todosAITextResponseMarkdown;
  final List<GroundingData> _todosGroundings;
  @override
  List<GroundingData> get todosGroundings {
    if (_todosGroundings is EqualUnmodifiableListView) return _todosGroundings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_todosGroundings);
  }

  @override
  final String shortAnswer;
  @override
  final String topic;
  @override
  final String definitionAITextResponse;
  final List<GroundingData> _definitionGroundings;
  @override
  List<GroundingData> get definitionGroundings {
    if (_definitionGroundings is EqualUnmodifiableListView) return _definitionGroundings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_definitionGroundings);
  }

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
  final LocationFormInfo? userLocation;
  @override
  @NullableTimestampConverter()
  final DateTime? preparedDateTime;
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

  @JsonKey(name: 'status')
  final String $type;

  @override
  String toString() {
    return 'Task.prepared(id: $id, userID: $userID, question: $question, todosAITextResponseMarkdown: $todosAITextResponseMarkdown, todosGroundings: $todosGroundings, shortAnswer: $shortAnswer, topic: $topic, definitionAITextResponse: $definitionAITextResponse, definitionGroundings: $definitionGroundings, locations: $locations, locationsAITextResponse: $locationsAITextResponse, locationsGroundings: $locationsGroundings, userLocation: $userLocation, preparedDateTime: $preparedDateTime, completedDateTime: $completedDateTime, createdDateTime: $createdDateTime, updatedDateTime: $updatedDateTime, serverCreatedDateTime: $serverCreatedDateTime, serverUpdatedDateTime: $serverUpdatedDateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskPreparedImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userID, userID) || other.userID == userID) &&
            (identical(other.question, question) || other.question == question) &&
            (identical(other.todosAITextResponseMarkdown, todosAITextResponseMarkdown) ||
                other.todosAITextResponseMarkdown == todosAITextResponseMarkdown) &&
            const DeepCollectionEquality().equals(other._todosGroundings, _todosGroundings) &&
            (identical(other.shortAnswer, shortAnswer) || other.shortAnswer == shortAnswer) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.definitionAITextResponse, definitionAITextResponse) || other.definitionAITextResponse == definitionAITextResponse) &&
            const DeepCollectionEquality().equals(other._definitionGroundings, _definitionGroundings) &&
            const DeepCollectionEquality().equals(other._locations, _locations) &&
            (identical(other.locationsAITextResponse, locationsAITextResponse) || other.locationsAITextResponse == locationsAITextResponse) &&
            const DeepCollectionEquality().equals(other._locationsGroundings, _locationsGroundings) &&
            (identical(other.userLocation, userLocation) || other.userLocation == userLocation) &&
            (identical(other.preparedDateTime, preparedDateTime) || other.preparedDateTime == preparedDateTime) &&
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
        userID,
        question,
        todosAITextResponseMarkdown,
        const DeepCollectionEquality().hash(_todosGroundings),
        shortAnswer,
        topic,
        definitionAITextResponse,
        const DeepCollectionEquality().hash(_definitionGroundings),
        const DeepCollectionEquality().hash(_locations),
        locationsAITextResponse,
        const DeepCollectionEquality().hash(_locationsGroundings),
        userLocation,
        preparedDateTime,
        completedDateTime,
        createdDateTime,
        updatedDateTime,
        serverCreatedDateTime,
        serverUpdatedDateTime
      ]);

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskPreparedImplCopyWith<_$TaskPreparedImpl> get copyWith => __$$TaskPreparedImplCopyWithImpl<_$TaskPreparedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String userID,
            String question,
            String todosAITextResponseMarkdown,
            List<GroundingData> todosGroundings,
            String shortAnswer,
            String topic,
            String definitionAITextResponse,
            List<GroundingData> definitionGroundings,
            List<AppLocation>? locations,
            String? locationsAITextResponse,
            List<GroundingData>? locationsGroundings,
            LocationFormInfo? userLocation,
            @NullableTimestampConverter() DateTime? preparedDateTime,
            @NullableTimestampConverter() DateTime? completedDateTime,
            @ClientCreatedTimestamp() DateTime? createdDateTime,
            @ClientUpdatedTimestamp() DateTime? updatedDateTime,
            @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
            @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime)
        prepared,
    required TResult Function(
            String id,
            String userID,
            String question,
            String? todosAITextResponseMarkdown,
            List<GroundingData>? todosGroundings,
            String? shortAnswer,
            String? topic,
            String? definitionAITextResponse,
            List<GroundingData>? definitionGroundings,
            @ClientCreatedTimestamp() DateTime? createdDateTime,
            @ClientUpdatedTimestamp() DateTime? updatedDateTime,
            @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
            @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime)
        preparing,
  }) {
    return prepared(
        id,
        userID,
        question,
        todosAITextResponseMarkdown,
        todosGroundings,
        shortAnswer,
        topic,
        definitionAITextResponse,
        definitionGroundings,
        locations,
        locationsAITextResponse,
        locationsGroundings,
        userLocation,
        preparedDateTime,
        completedDateTime,
        createdDateTime,
        updatedDateTime,
        serverCreatedDateTime,
        serverUpdatedDateTime);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String userID,
            String question,
            String todosAITextResponseMarkdown,
            List<GroundingData> todosGroundings,
            String shortAnswer,
            String topic,
            String definitionAITextResponse,
            List<GroundingData> definitionGroundings,
            List<AppLocation>? locations,
            String? locationsAITextResponse,
            List<GroundingData>? locationsGroundings,
            LocationFormInfo? userLocation,
            @NullableTimestampConverter() DateTime? preparedDateTime,
            @NullableTimestampConverter() DateTime? completedDateTime,
            @ClientCreatedTimestamp() DateTime? createdDateTime,
            @ClientUpdatedTimestamp() DateTime? updatedDateTime,
            @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
            @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime)?
        prepared,
    TResult? Function(
            String id,
            String userID,
            String question,
            String? todosAITextResponseMarkdown,
            List<GroundingData>? todosGroundings,
            String? shortAnswer,
            String? topic,
            String? definitionAITextResponse,
            List<GroundingData>? definitionGroundings,
            @ClientCreatedTimestamp() DateTime? createdDateTime,
            @ClientUpdatedTimestamp() DateTime? updatedDateTime,
            @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
            @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime)?
        preparing,
  }) {
    return prepared?.call(
        id,
        userID,
        question,
        todosAITextResponseMarkdown,
        todosGroundings,
        shortAnswer,
        topic,
        definitionAITextResponse,
        definitionGroundings,
        locations,
        locationsAITextResponse,
        locationsGroundings,
        userLocation,
        preparedDateTime,
        completedDateTime,
        createdDateTime,
        updatedDateTime,
        serverCreatedDateTime,
        serverUpdatedDateTime);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String userID,
            String question,
            String todosAITextResponseMarkdown,
            List<GroundingData> todosGroundings,
            String shortAnswer,
            String topic,
            String definitionAITextResponse,
            List<GroundingData> definitionGroundings,
            List<AppLocation>? locations,
            String? locationsAITextResponse,
            List<GroundingData>? locationsGroundings,
            LocationFormInfo? userLocation,
            @NullableTimestampConverter() DateTime? preparedDateTime,
            @NullableTimestampConverter() DateTime? completedDateTime,
            @ClientCreatedTimestamp() DateTime? createdDateTime,
            @ClientUpdatedTimestamp() DateTime? updatedDateTime,
            @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
            @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime)?
        prepared,
    TResult Function(
            String id,
            String userID,
            String question,
            String? todosAITextResponseMarkdown,
            List<GroundingData>? todosGroundings,
            String? shortAnswer,
            String? topic,
            String? definitionAITextResponse,
            List<GroundingData>? definitionGroundings,
            @ClientCreatedTimestamp() DateTime? createdDateTime,
            @ClientUpdatedTimestamp() DateTime? updatedDateTime,
            @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
            @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime)?
        preparing,
    required TResult orElse(),
  }) {
    if (prepared != null) {
      return prepared(
          id,
          userID,
          question,
          todosAITextResponseMarkdown,
          todosGroundings,
          shortAnswer,
          topic,
          definitionAITextResponse,
          definitionGroundings,
          locations,
          locationsAITextResponse,
          locationsGroundings,
          userLocation,
          preparedDateTime,
          completedDateTime,
          createdDateTime,
          updatedDateTime,
          serverCreatedDateTime,
          serverUpdatedDateTime);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskPrepared value) prepared,
    required TResult Function(TaskPreparing value) preparing,
  }) {
    return prepared(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskPrepared value)? prepared,
    TResult? Function(TaskPreparing value)? preparing,
  }) {
    return prepared?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskPrepared value)? prepared,
    TResult Function(TaskPreparing value)? preparing,
    required TResult orElse(),
  }) {
    if (prepared != null) {
      return prepared(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskPreparedImplToJson(
      this,
    );
  }
}

abstract class TaskPrepared extends Task {
  const factory TaskPrepared(
      {required final String id,
      required final String userID,
      required final String question,
      required final String todosAITextResponseMarkdown,
      required final List<GroundingData> todosGroundings,
      required final String shortAnswer,
      required final String topic,
      required final String definitionAITextResponse,
      required final List<GroundingData> definitionGroundings,
      final List<AppLocation>? locations,
      final String? locationsAITextResponse,
      final List<GroundingData>? locationsGroundings,
      final LocationFormInfo? userLocation,
      @NullableTimestampConverter() required final DateTime? preparedDateTime,
      @NullableTimestampConverter() required final DateTime? completedDateTime,
      @ClientCreatedTimestamp() final DateTime? createdDateTime,
      @ClientUpdatedTimestamp() final DateTime? updatedDateTime,
      @ServerCreatedTimestamp() final DateTime? serverCreatedDateTime,
      @ServerUpdatedTimestamp() final DateTime? serverUpdatedDateTime}) = _$TaskPreparedImpl;
  const TaskPrepared._() : super._();

  factory TaskPrepared.fromJson(Map<String, dynamic> json) = _$TaskPreparedImpl.fromJson;

  @override
  String get id;
  @override
  String get userID;
  @override
  String get question;
  @override
  String get todosAITextResponseMarkdown;
  @override
  List<GroundingData> get todosGroundings;
  @override
  String get shortAnswer;
  @override
  String get topic;
  @override
  String get definitionAITextResponse;
  @override
  List<GroundingData> get definitionGroundings;
  List<AppLocation>? get locations;
  String? get locationsAITextResponse;
  List<GroundingData>? get locationsGroundings;
  LocationFormInfo? get userLocation;
  @NullableTimestampConverter()
  DateTime? get preparedDateTime;
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

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskPreparedImplCopyWith<_$TaskPreparedImpl> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TaskPreparingImplCopyWith<$Res> implements $TaskCopyWith<$Res> {
  factory _$$TaskPreparingImplCopyWith(_$TaskPreparingImpl value, $Res Function(_$TaskPreparingImpl) then) = __$$TaskPreparingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userID,
      String question,
      String? todosAITextResponseMarkdown,
      List<GroundingData>? todosGroundings,
      String? shortAnswer,
      String? topic,
      String? definitionAITextResponse,
      List<GroundingData>? definitionGroundings,
      @ClientCreatedTimestamp() DateTime? createdDateTime,
      @ClientUpdatedTimestamp() DateTime? updatedDateTime,
      @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
      @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime});
}

/// @nodoc
class __$$TaskPreparingImplCopyWithImpl<$Res> extends _$TaskCopyWithImpl<$Res, _$TaskPreparingImpl> implements _$$TaskPreparingImplCopyWith<$Res> {
  __$$TaskPreparingImplCopyWithImpl(_$TaskPreparingImpl _value, $Res Function(_$TaskPreparingImpl) _then) : super(_value, _then);

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userID = null,
    Object? question = null,
    Object? todosAITextResponseMarkdown = freezed,
    Object? todosGroundings = freezed,
    Object? shortAnswer = freezed,
    Object? topic = freezed,
    Object? definitionAITextResponse = freezed,
    Object? definitionGroundings = freezed,
    Object? createdDateTime = freezed,
    Object? updatedDateTime = freezed,
    Object? serverCreatedDateTime = freezed,
    Object? serverUpdatedDateTime = freezed,
  }) {
    return _then(_$TaskPreparingImpl(
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
      todosAITextResponseMarkdown: freezed == todosAITextResponseMarkdown
          ? _value.todosAITextResponseMarkdown
          : todosAITextResponseMarkdown // ignore: cast_nullable_to_non_nullable
              as String?,
      todosGroundings: freezed == todosGroundings
          ? _value._todosGroundings
          : todosGroundings // ignore: cast_nullable_to_non_nullable
              as List<GroundingData>?,
      shortAnswer: freezed == shortAnswer
          ? _value.shortAnswer
          : shortAnswer // ignore: cast_nullable_to_non_nullable
              as String?,
      topic: freezed == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String?,
      definitionAITextResponse: freezed == definitionAITextResponse
          ? _value.definitionAITextResponse
          : definitionAITextResponse // ignore: cast_nullable_to_non_nullable
              as String?,
      definitionGroundings: freezed == definitionGroundings
          ? _value._definitionGroundings
          : definitionGroundings // ignore: cast_nullable_to_non_nullable
              as List<GroundingData>?,
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
class _$TaskPreparingImpl extends TaskPreparing {
  const _$TaskPreparingImpl(
      {required this.id,
      required this.userID,
      required this.question,
      this.todosAITextResponseMarkdown,
      final List<GroundingData>? todosGroundings,
      this.shortAnswer,
      this.topic,
      this.definitionAITextResponse,
      final List<GroundingData>? definitionGroundings,
      @ClientCreatedTimestamp() this.createdDateTime,
      @ClientUpdatedTimestamp() this.updatedDateTime,
      @ServerCreatedTimestamp() this.serverCreatedDateTime,
      @ServerUpdatedTimestamp() this.serverUpdatedDateTime,
      final String? $type})
      : _todosGroundings = todosGroundings,
        _definitionGroundings = definitionGroundings,
        $type = $type ?? 'preparing',
        super._();

  factory _$TaskPreparingImpl.fromJson(Map<String, dynamic> json) => _$$TaskPreparingImplFromJson(json);

  @override
  final String id;
  @override
  final String userID;
  @override
  final String question;
  @override
  final String? todosAITextResponseMarkdown;
  final List<GroundingData>? _todosGroundings;
  @override
  List<GroundingData>? get todosGroundings {
    final value = _todosGroundings;
    if (value == null) return null;
    if (_todosGroundings is EqualUnmodifiableListView) return _todosGroundings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? shortAnswer;
  @override
  final String? topic;
  @override
  final String? definitionAITextResponse;
  final List<GroundingData>? _definitionGroundings;
  @override
  List<GroundingData>? get definitionGroundings {
    final value = _definitionGroundings;
    if (value == null) return null;
    if (_definitionGroundings is EqualUnmodifiableListView) return _definitionGroundings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

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

  @JsonKey(name: 'status')
  final String $type;

  @override
  String toString() {
    return 'Task.preparing(id: $id, userID: $userID, question: $question, todosAITextResponseMarkdown: $todosAITextResponseMarkdown, todosGroundings: $todosGroundings, shortAnswer: $shortAnswer, topic: $topic, definitionAITextResponse: $definitionAITextResponse, definitionGroundings: $definitionGroundings, createdDateTime: $createdDateTime, updatedDateTime: $updatedDateTime, serverCreatedDateTime: $serverCreatedDateTime, serverUpdatedDateTime: $serverUpdatedDateTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskPreparingImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userID, userID) || other.userID == userID) &&
            (identical(other.question, question) || other.question == question) &&
            (identical(other.todosAITextResponseMarkdown, todosAITextResponseMarkdown) ||
                other.todosAITextResponseMarkdown == todosAITextResponseMarkdown) &&
            const DeepCollectionEquality().equals(other._todosGroundings, _todosGroundings) &&
            (identical(other.shortAnswer, shortAnswer) || other.shortAnswer == shortAnswer) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.definitionAITextResponse, definitionAITextResponse) || other.definitionAITextResponse == definitionAITextResponse) &&
            const DeepCollectionEquality().equals(other._definitionGroundings, _definitionGroundings) &&
            (identical(other.createdDateTime, createdDateTime) || other.createdDateTime == createdDateTime) &&
            (identical(other.updatedDateTime, updatedDateTime) || other.updatedDateTime == updatedDateTime) &&
            (identical(other.serverCreatedDateTime, serverCreatedDateTime) || other.serverCreatedDateTime == serverCreatedDateTime) &&
            (identical(other.serverUpdatedDateTime, serverUpdatedDateTime) || other.serverUpdatedDateTime == serverUpdatedDateTime));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userID,
      question,
      todosAITextResponseMarkdown,
      const DeepCollectionEquality().hash(_todosGroundings),
      shortAnswer,
      topic,
      definitionAITextResponse,
      const DeepCollectionEquality().hash(_definitionGroundings),
      createdDateTime,
      updatedDateTime,
      serverCreatedDateTime,
      serverUpdatedDateTime);

  /// Create a copy of Task
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskPreparingImplCopyWith<_$TaskPreparingImpl> get copyWith => __$$TaskPreparingImplCopyWithImpl<_$TaskPreparingImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            String id,
            String userID,
            String question,
            String todosAITextResponseMarkdown,
            List<GroundingData> todosGroundings,
            String shortAnswer,
            String topic,
            String definitionAITextResponse,
            List<GroundingData> definitionGroundings,
            List<AppLocation>? locations,
            String? locationsAITextResponse,
            List<GroundingData>? locationsGroundings,
            LocationFormInfo? userLocation,
            @NullableTimestampConverter() DateTime? preparedDateTime,
            @NullableTimestampConverter() DateTime? completedDateTime,
            @ClientCreatedTimestamp() DateTime? createdDateTime,
            @ClientUpdatedTimestamp() DateTime? updatedDateTime,
            @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
            @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime)
        prepared,
    required TResult Function(
            String id,
            String userID,
            String question,
            String? todosAITextResponseMarkdown,
            List<GroundingData>? todosGroundings,
            String? shortAnswer,
            String? topic,
            String? definitionAITextResponse,
            List<GroundingData>? definitionGroundings,
            @ClientCreatedTimestamp() DateTime? createdDateTime,
            @ClientUpdatedTimestamp() DateTime? updatedDateTime,
            @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
            @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime)
        preparing,
  }) {
    return preparing(id, userID, question, todosAITextResponseMarkdown, todosGroundings, shortAnswer, topic, definitionAITextResponse,
        definitionGroundings, createdDateTime, updatedDateTime, serverCreatedDateTime, serverUpdatedDateTime);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(
            String id,
            String userID,
            String question,
            String todosAITextResponseMarkdown,
            List<GroundingData> todosGroundings,
            String shortAnswer,
            String topic,
            String definitionAITextResponse,
            List<GroundingData> definitionGroundings,
            List<AppLocation>? locations,
            String? locationsAITextResponse,
            List<GroundingData>? locationsGroundings,
            LocationFormInfo? userLocation,
            @NullableTimestampConverter() DateTime? preparedDateTime,
            @NullableTimestampConverter() DateTime? completedDateTime,
            @ClientCreatedTimestamp() DateTime? createdDateTime,
            @ClientUpdatedTimestamp() DateTime? updatedDateTime,
            @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
            @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime)?
        prepared,
    TResult? Function(
            String id,
            String userID,
            String question,
            String? todosAITextResponseMarkdown,
            List<GroundingData>? todosGroundings,
            String? shortAnswer,
            String? topic,
            String? definitionAITextResponse,
            List<GroundingData>? definitionGroundings,
            @ClientCreatedTimestamp() DateTime? createdDateTime,
            @ClientUpdatedTimestamp() DateTime? updatedDateTime,
            @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
            @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime)?
        preparing,
  }) {
    return preparing?.call(id, userID, question, todosAITextResponseMarkdown, todosGroundings, shortAnswer, topic, definitionAITextResponse,
        definitionGroundings, createdDateTime, updatedDateTime, serverCreatedDateTime, serverUpdatedDateTime);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(
            String id,
            String userID,
            String question,
            String todosAITextResponseMarkdown,
            List<GroundingData> todosGroundings,
            String shortAnswer,
            String topic,
            String definitionAITextResponse,
            List<GroundingData> definitionGroundings,
            List<AppLocation>? locations,
            String? locationsAITextResponse,
            List<GroundingData>? locationsGroundings,
            LocationFormInfo? userLocation,
            @NullableTimestampConverter() DateTime? preparedDateTime,
            @NullableTimestampConverter() DateTime? completedDateTime,
            @ClientCreatedTimestamp() DateTime? createdDateTime,
            @ClientUpdatedTimestamp() DateTime? updatedDateTime,
            @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
            @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime)?
        prepared,
    TResult Function(
            String id,
            String userID,
            String question,
            String? todosAITextResponseMarkdown,
            List<GroundingData>? todosGroundings,
            String? shortAnswer,
            String? topic,
            String? definitionAITextResponse,
            List<GroundingData>? definitionGroundings,
            @ClientCreatedTimestamp() DateTime? createdDateTime,
            @ClientUpdatedTimestamp() DateTime? updatedDateTime,
            @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
            @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime)?
        preparing,
    required TResult orElse(),
  }) {
    if (preparing != null) {
      return preparing(id, userID, question, todosAITextResponseMarkdown, todosGroundings, shortAnswer, topic, definitionAITextResponse,
          definitionGroundings, createdDateTime, updatedDateTime, serverCreatedDateTime, serverUpdatedDateTime);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(TaskPrepared value) prepared,
    required TResult Function(TaskPreparing value) preparing,
  }) {
    return preparing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(TaskPrepared value)? prepared,
    TResult? Function(TaskPreparing value)? preparing,
  }) {
    return preparing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(TaskPrepared value)? prepared,
    TResult Function(TaskPreparing value)? preparing,
    required TResult orElse(),
  }) {
    if (preparing != null) {
      return preparing(this);
    }
    return orElse();
  }

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskPreparingImplToJson(
      this,
    );
  }
}

abstract class TaskPreparing extends Task {
  const factory TaskPreparing(
      {required final String id,
      required final String userID,
      required final String question,
      final String? todosAITextResponseMarkdown,
      final List<GroundingData>? todosGroundings,
      final String? shortAnswer,
      final String? topic,
      final String? definitionAITextResponse,
      final List<GroundingData>? definitionGroundings,
      @ClientCreatedTimestamp() final DateTime? createdDateTime,
      @ClientUpdatedTimestamp() final DateTime? updatedDateTime,
      @ServerCreatedTimestamp() final DateTime? serverCreatedDateTime,
      @ServerUpdatedTimestamp() final DateTime? serverUpdatedDateTime}) = _$TaskPreparingImpl;
  const TaskPreparing._() : super._();

  factory TaskPreparing.fromJson(Map<String, dynamic> json) = _$TaskPreparingImpl.fromJson;

  @override
  String get id;
  @override
  String get userID;
  @override
  String get question;
  @override
  String? get todosAITextResponseMarkdown;
  @override
  List<GroundingData>? get todosGroundings;
  @override
  String? get shortAnswer;
  @override
  String? get topic;
  @override
  String? get definitionAITextResponse;
  @override
  List<GroundingData>? get definitionGroundings;
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
  _$$TaskPreparingImplCopyWith<_$TaskPreparingImpl> get copyWith => throw _privateConstructorUsedError;
}
