import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todomaker/entity/timestamp.dart';

part 'grounding_data.g.dart';
part 'grounding_data.freezed.dart';

@freezed
class GroundingData with _$GroundingData {
  const GroundingData._();
  @JsonSerializable(explicitToJson: true)
  const factory GroundingData({
    required String id,
    required int? index,
    required String? url,
    required String? title,
    @ClientCreatedTimestamp() DateTime? createdDateTime,
    @ClientUpdatedTimestamp() DateTime? updatedDateTime,
    @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
    @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime,
  }) = _GroundingData;

  factory GroundingData.fromJson(Map<String, dynamic> json) => _$GroundingDataFromJson(json);
}

/*
import { z } from "zod";

export const GroundingDataSchema = z.object({
  url: z.string().optional(),
  title: z.string().optional(),
  index: z.number().optional(),
});

export type GroundingData = z.infer<typeof GroundingDataSchema>;
*/
