import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todomaker/entity/grounding_data.dart';
import 'package:todomaker/entity/timestamp.dart';

part 'todo.g.dart';
part 'todo.freezed.dart';

@freezed
class Todo with _$Todo {
  const Todo._();
  @JsonSerializable(explicitToJson: true)
  const factory Todo({
    required String id,
    required String taskID,
    required String content,
    required String supplement,
    required String aiTextResponse,
    required List<GroundingData> groundings,
    @ClientCreatedTimestamp() DateTime? createdDateTime,
    @ClientUpdatedTimestamp() DateTime? updatedDateTime,
    @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
    @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}

/*
import { z } from "zod";
import { GroundingDataSchema } from "./grounding";

export const TODOSchema = z.object({
  id: z.string(),
  userID: z.string(),
  taskID: z.string(),
  content: z.string(),
  supplement: z.string().optional(),
  aiTextResponse: z.string(),
  groundings: z.array(GroundingDataSchema),
});

export type TODO = z.infer<typeof TODOSchema>;
*/