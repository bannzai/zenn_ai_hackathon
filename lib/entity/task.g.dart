// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TaskImpl _$$TaskImplFromJson(Map<String, dynamic> json) => _$TaskImpl(
      id: json['id'] as String,
      userID: json['userID'] as String,
      question: json['question'] as String,
      shortAnswer: json['shortAnswer'] as String,
      topic: json['topic'] as String,
      definition: json['definition'] as String,
      todoAITextResponse: json['todoAITextResponse'] as String,
      todoGroundings: (json['todoGroundings'] as List<dynamic>).map((e) => GroundingData.fromJson(e as Map<String, dynamic>)).toList(),
      completed: json['completed'] as bool,
      createdDateTime: const ClientCreatedTimestamp().fromJson(json['createdDateTime'] as Timestamp?),
      updatedDateTime: const ClientUpdatedTimestamp().fromJson(json['updatedDateTime'] as Timestamp?),
      serverCreatedDateTime: const ServerCreatedTimestamp().fromJson(json['serverCreatedDateTime']),
      serverUpdatedDateTime: const ServerUpdatedTimestamp().fromJson(json['serverUpdatedDateTime']),
    );

Map<String, dynamic> _$$TaskImplToJson(_$TaskImpl instance) => <String, dynamic>{
      'id': instance.id,
      'userID': instance.userID,
      'question': instance.question,
      'shortAnswer': instance.shortAnswer,
      'topic': instance.topic,
      'definition': instance.definition,
      'todoAITextResponse': instance.todoAITextResponse,
      'todoGroundings': instance.todoGroundings.map((e) => e.toJson()).toList(),
      'completed': instance.completed,
      'createdDateTime': const ClientCreatedTimestamp().toJson(instance.createdDateTime),
      'updatedDateTime': const ClientUpdatedTimestamp().toJson(instance.updatedDateTime),
      'serverCreatedDateTime': const ServerCreatedTimestamp().toJson(instance.serverCreatedDateTime),
      'serverUpdatedDateTime': const ServerUpdatedTimestamp().toJson(instance.serverUpdatedDateTime),
    };
