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
      aiTextResponse: json['aiTextResponse'] as String,
      groundings: (json['groundings'] as List<dynamic>).map((e) => GroundingData.fromJson(e as Map<String, dynamic>)).toList(),
      completed: json['completed'] as bool? ?? false,
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
      'aiTextResponse': instance.aiTextResponse,
      'groundings': instance.groundings.map((e) => e.toJson()).toList(),
      'completed': instance.completed,
      'createdDateTime': const ClientCreatedTimestamp().toJson(instance.createdDateTime),
      'updatedDateTime': const ClientUpdatedTimestamp().toJson(instance.updatedDateTime),
      'serverCreatedDateTime': const ServerCreatedTimestamp().toJson(instance.serverCreatedDateTime),
      'serverUpdatedDateTime': const ServerUpdatedTimestamp().toJson(instance.serverUpdatedDateTime),
    };
