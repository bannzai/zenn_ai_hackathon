// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grounding_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GroundingDataImpl _$$GroundingDataImplFromJson(Map<String, dynamic> json) => _$GroundingDataImpl(
      id: json['id'] as String,
      index: (json['index'] as num?)?.toInt(),
      url: json['url'] as String?,
      title: json['title'] as String?,
      createdDateTime: const ClientCreatedTimestamp().fromJson(json['createdDateTime'] as Timestamp?),
      updatedDateTime: const ClientUpdatedTimestamp().fromJson(json['updatedDateTime'] as Timestamp?),
      serverCreatedDateTime: const ServerCreatedTimestamp().fromJson(json['serverCreatedDateTime']),
      serverUpdatedDateTime: const ServerUpdatedTimestamp().fromJson(json['serverUpdatedDateTime']),
    );

Map<String, dynamic> _$$GroundingDataImplToJson(_$GroundingDataImpl instance) => <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'url': instance.url,
      'title': instance.title,
      'createdDateTime': const ClientCreatedTimestamp().toJson(instance.createdDateTime),
      'updatedDateTime': const ClientUpdatedTimestamp().toJson(instance.updatedDateTime),
      'serverCreatedDateTime': const ServerCreatedTimestamp().toJson(instance.serverCreatedDateTime),
      'serverUpdatedDateTime': const ServerUpdatedTimestamp().toJson(instance.serverUpdatedDateTime),
    };
