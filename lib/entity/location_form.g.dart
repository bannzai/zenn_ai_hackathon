// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_form.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationFormInfoImpl _$$LocationFormInfoImplFromJson(Map<String, dynamic> json) => _$LocationFormInfoImpl(
      name: json['name'] as String,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$LocationFormInfoImplToJson(_$LocationFormInfoImpl instance) => <String, dynamic>{
      'name': instance.name,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
