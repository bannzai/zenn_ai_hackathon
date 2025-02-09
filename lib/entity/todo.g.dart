// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoImpl _$$TodoImplFromJson(Map<String, dynamic> json) => _$TodoImpl(
      id: json['id'] as String,
      taskID: json['taskID'] as String,
      content: json['content'] as String,
      supplement: json['supplement'] as String?,
      aiTextResponseMarkdown: json['aiTextResponseMarkdown'] as String?,
      groundings: (json['groundings'] as List<dynamic>?)?.map((e) => GroundingData.fromJson(e as Map<String, dynamic>)).toList(),
      locations: (json['locations'] as List<dynamic>?)?.map((e) => AppLocation.fromJson(e as Map<String, dynamic>)).toList(),
      locationsAITextResponse: json['locationsAITextResponse'] as String?,
      locationsGroundings: (json['locationsGroundings'] as List<dynamic>?)?.map((e) => GroundingData.fromJson(e as Map<String, dynamic>)).toList(),
      completedDateTime: const NullableTimestampConverter().fromJson(json['completedDateTime'] as Timestamp?),
      createdDateTime: const ClientCreatedTimestamp().fromJson(json['createdDateTime'] as Timestamp?),
      updatedDateTime: const ClientUpdatedTimestamp().fromJson(json['updatedDateTime'] as Timestamp?),
      serverCreatedDateTime: const ServerCreatedTimestamp().fromJson(json['serverCreatedDateTime']),
      serverUpdatedDateTime: const ServerUpdatedTimestamp().fromJson(json['serverUpdatedDateTime']),
    );

Map<String, dynamic> _$$TodoImplToJson(_$TodoImpl instance) => <String, dynamic>{
      'id': instance.id,
      'taskID': instance.taskID,
      'content': instance.content,
      'supplement': instance.supplement,
      'aiTextResponseMarkdown': instance.aiTextResponseMarkdown,
      'groundings': instance.groundings?.map((e) => e.toJson()).toList(),
      'locations': instance.locations?.map((e) => e.toJson()).toList(),
      'locationsAITextResponse': instance.locationsAITextResponse,
      'locationsGroundings': instance.locationsGroundings?.map((e) => e.toJson()).toList(),
      'completedDateTime': const NullableTimestampConverter().toJson(instance.completedDateTime),
      'createdDateTime': const ClientCreatedTimestamp().toJson(instance.createdDateTime),
      'updatedDateTime': const ClientUpdatedTimestamp().toJson(instance.updatedDateTime),
      'serverCreatedDateTime': const ServerCreatedTimestamp().toJson(instance.serverCreatedDateTime),
      'serverUpdatedDateTime': const ServerUpdatedTimestamp().toJson(instance.serverUpdatedDateTime),
    };
