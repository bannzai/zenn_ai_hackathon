import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_form.g.dart';
part 'location_form.freezed.dart';

@freezed
class LocationFormInfo with _$LocationFormInfo {
  const factory LocationFormInfo({
    required String name,
    required double? latitude,
    required double? longitude,
  }) = _LocationFormInfo;

  factory LocationFormInfo.fromJson(Map<String, dynamic> json) => _$LocationFormInfoFromJson(json);
}
