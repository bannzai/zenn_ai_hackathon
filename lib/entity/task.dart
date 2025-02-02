import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todomaker/entity/grounding_data.dart';
import 'package:todomaker/entity/timestamp.dart';

part 'task.g.dart';
part 'task.freezed.dart';

@freezed
class Task with _$Task {
  const Task._();
  @JsonSerializable(explicitToJson: true)
  const factory Task({
    required String id,
    required String userID,
    required String question,
    required String aiTextResponse,
    required List<String> todoIDs,
    required List<GroundingData> groundings,
    required bool completed,
    @ClientCreatedTimestamp() DateTime? createdDateTime,
    @ClientUpdatedTimestamp() DateTime? updatedDateTime,
    @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
    @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

/*
export const TaskSchema = z.object({
  id: z.string(),
  userID: z.string(),
  question: z.string(),
  aiTextResponse: z.string(),
  todoIDs: z.array(z.string()),
  groundings: z.array(GroundingDataSchema),
  completed: z.boolean().default(false),
});
*/
