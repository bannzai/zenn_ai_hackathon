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
      userLocation: json['userLocation'] == null ? null : AppLocation.fromJson(json['userLocation'] as Map<String, dynamic>),
      locations: (json['locations'] as List<dynamic>?)?.map((e) => AppLocation.fromJson(e as Map<String, dynamic>)).toList(),
      locationsAITextResponse: json['locationsAITextResponse'] as String?,
      locationsGroundings: (json['locationsGroundings'] as List<dynamic>?)?.map((e) => GroundingData.fromJson(e as Map<String, dynamic>)).toList(),
      timeRequired: (json['timeRequired'] as num?)?.toInt(),
      timeRequiredAITextResponse: json['timeRequiredAITextResponse'] as String?,
      timeRequiredGroundings:
          (json['timeRequiredGroundings'] as List<dynamic>?)?.map((e) => GroundingData.fromJson(e as Map<String, dynamic>)).toList(),
      userTimeRequired: (json['userTimeRequired'] as num?)?.toInt(),
      calendarSchedules:
          (json['calendarSchedules'] as List<dynamic>?)?.map((e) => TodoCalendarSchedule.fromJson(e as Map<String, dynamic>)).toList() ?? const [],
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
      'userLocation': instance.userLocation?.toJson(),
      'locations': instance.locations?.map((e) => e.toJson()).toList(),
      'locationsAITextResponse': instance.locationsAITextResponse,
      'locationsGroundings': instance.locationsGroundings?.map((e) => e.toJson()).toList(),
      'timeRequired': instance.timeRequired,
      'timeRequiredAITextResponse': instance.timeRequiredAITextResponse,
      'timeRequiredGroundings': instance.timeRequiredGroundings?.map((e) => e.toJson()).toList(),
      'userTimeRequired': instance.userTimeRequired,
      'calendarSchedules': instance.calendarSchedules.map((e) => e.toJson()).toList(),
      'completedDateTime': const NullableTimestampConverter().toJson(instance.completedDateTime),
      'createdDateTime': const ClientCreatedTimestamp().toJson(instance.createdDateTime),
      'updatedDateTime': const ClientUpdatedTimestamp().toJson(instance.updatedDateTime),
      'serverCreatedDateTime': const ServerCreatedTimestamp().toJson(instance.serverCreatedDateTime),
      'serverUpdatedDateTime': const ServerUpdatedTimestamp().toJson(instance.serverUpdatedDateTime),
    };

_$TodoCalendarScheduleImpl _$$TodoCalendarScheduleImplFromJson(Map<String, dynamic> json) => _$TodoCalendarScheduleImpl(
      calendarID: json['calendarID'] as String,
      calendarEventID: json['calendarEventID'] as String,
    );

Map<String, dynamic> _$$TodoCalendarScheduleImplToJson(_$TodoCalendarScheduleImpl instance) => <String, dynamic>{
      'calendarID': instance.calendarID,
      'calendarEventID': instance.calendarEventID,
    };
