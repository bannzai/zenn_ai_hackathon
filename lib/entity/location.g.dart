// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LocationImpl _$$LocationImplFromJson(Map<String, dynamic> json) => _$LocationImpl(
      name: json['name'] as String,
      postalCode: json['postalCode'] as String?,
      address: json['address'] as String?,
      tel: json['tel'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$LocationImplToJson(_$LocationImpl instance) => <String, dynamic>{
      'name': instance.name,
      'postalCode': instance.postalCode,
      'address': instance.address,
      'tel': instance.tel,
      'email': instance.email,
    };
