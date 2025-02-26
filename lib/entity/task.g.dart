// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskPreparedImpl _$$TaskPreparedImplFromJson(Map<String, dynamic> json) => _$TaskPreparedImpl(
      id: json['id'] as String,
      userID: json['userID'] as String,
      question: json['question'] as String,
      todosAITextResponseMarkdown: json['todosAITextResponseMarkdown'] as String,
      todosGroundings: (json['todosGroundings'] as List<dynamic>).map((e) => GroundingData.fromJson(e as Map<String, dynamic>)).toList(),
      shortAnswer: json['shortAnswer'] as String,
      topic: json['topic'] as String,
      definitionAITextResponse: json['definitionAITextResponse'] as String,
      definitionGroundings: (json['definitionGroundings'] as List<dynamic>).map((e) => GroundingData.fromJson(e as Map<String, dynamic>)).toList(),
      locations: (json['locations'] as List<dynamic>?)?.map((e) => AppLocation.fromJson(e as Map<String, dynamic>)).toList(),
      locationsAITextResponse: json['locationsAITextResponse'] as String?,
      locationsGroundings: (json['locationsGroundings'] as List<dynamic>?)?.map((e) => GroundingData.fromJson(e as Map<String, dynamic>)).toList(),
      userLocation: json['userLocation'] == null ? null : LocationFormInfo.fromJson(json['userLocation'] as Map<String, dynamic>),
      preparedDateTime: const NullableTimestampConverter().fromJson(json['preparedDateTime'] as Timestamp?),
      completedDateTime: const NullableTimestampConverter().fromJson(json['completedDateTime'] as Timestamp?),
      createdDateTime: const ClientCreatedTimestamp().fromJson(json['createdDateTime'] as Timestamp?),
      updatedDateTime: const ClientUpdatedTimestamp().fromJson(json['updatedDateTime'] as Timestamp?),
      serverCreatedDateTime: const ServerCreatedTimestamp().fromJson(json['serverCreatedDateTime']),
      serverUpdatedDateTime: const ServerUpdatedTimestamp().fromJson(json['serverUpdatedDateTime']),
      $type: json['status'] as String?,
    );

Map<String, dynamic> _$$TaskPreparedImplToJson(_$TaskPreparedImpl instance) => <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'question': instance.question,
      'todosAITextResponseMarkdown': instance.todosAITextResponseMarkdown,
      'todosGroundings': instance.todosGroundings.map((e) => e.toJson()).toList(),
      'shortAnswer': instance.shortAnswer,
      'topic': instance.topic,
      'definitionAITextResponse': instance.definitionAITextResponse,
      'definitionGroundings': instance.definitionGroundings.map((e) => e.toJson()).toList(),
      'locations': instance.locations?.map((e) => e.toJson()).toList(),
      'locationsAITextResponse': instance.locationsAITextResponse,
      'locationsGroundings': instance.locationsGroundings?.map((e) => e.toJson()).toList(),
      'userLocation': instance.userLocation?.toJson(),
      'preparedDateTime': const NullableTimestampConverter().toJson(instance.preparedDateTime),
      'completedDateTime': const NullableTimestampConverter().toJson(instance.completedDateTime),
      'createdDateTime': const ClientCreatedTimestamp().toJson(instance.createdDateTime),
      'updatedDateTime': const ClientUpdatedTimestamp().toJson(instance.updatedDateTime),
      'serverCreatedDateTime': const ServerCreatedTimestamp().toJson(instance.serverCreatedDateTime),
      'serverUpdatedDateTime': const ServerUpdatedTimestamp().toJson(instance.serverUpdatedDateTime),
      'status': instance.$type,
    };

_$TaskPreparingImpl _$$TaskPreparingImplFromJson(Map<String, dynamic> json) => _$TaskPreparingImpl(
      id: json['id'] as String,
      userID: json['userID'] as String,
      question: json['question'] as String,
      todosAITextResponseMarkdown: json['todosAITextResponseMarkdown'] as String?,
      todosGroundings: (json['todosGroundings'] as List<dynamic>?)?.map((e) => GroundingData.fromJson(e as Map<String, dynamic>)).toList(),
      shortAnswer: json['shortAnswer'] as String?,
      topic: json['topic'] as String?,
      definitionAITextResponse: json['definitionAITextResponse'] as String?,
      definitionGroundings: (json['definitionGroundings'] as List<dynamic>?)?.map((e) => GroundingData.fromJson(e as Map<String, dynamic>)).toList(),
      createdDateTime: const ClientCreatedTimestamp().fromJson(json['createdDateTime'] as Timestamp?),
      updatedDateTime: const ClientUpdatedTimestamp().fromJson(json['updatedDateTime'] as Timestamp?),
      serverCreatedDateTime: const ServerCreatedTimestamp().fromJson(json['serverCreatedDateTime']),
      serverUpdatedDateTime: const ServerUpdatedTimestamp().fromJson(json['serverUpdatedDateTime']),
      $type: json['status'] as String?,
    );

Map<String, dynamic> _$$TaskPreparingImplToJson(_$TaskPreparingImpl instance) => <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'question': instance.question,
      'todosAITextResponseMarkdown': instance.todosAITextResponseMarkdown,
      'todosGroundings': instance.todosGroundings?.map((e) => e.toJson()).toList(),
      'shortAnswer': instance.shortAnswer,
      'topic': instance.topic,
      'definitionAITextResponse': instance.definitionAITextResponse,
      'definitionGroundings': instance.definitionGroundings?.map((e) => e.toJson()).toList(),
      'createdDateTime': const ClientCreatedTimestamp().toJson(instance.createdDateTime),
      'updatedDateTime': const ClientUpdatedTimestamp().toJson(instance.updatedDateTime),
      'serverCreatedDateTime': const ServerCreatedTimestamp().toJson(instance.serverCreatedDateTime),
      'serverUpdatedDateTime': const ServerUpdatedTimestamp().toJson(instance.serverUpdatedDateTime),
      'status': instance.$type,
    };
