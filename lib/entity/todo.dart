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
    required String? supplement,
    required String aiTextResponseMarkdown,
    required List<GroundingData> groundings,
    @NullableTimestampConverter() DateTime? completedDateTime,
    @ClientCreatedTimestamp() DateTime? createdDateTime,
    @ClientUpdatedTimestamp() DateTime? updatedDateTime,
    @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
    @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}

/*
export const TaskSchema = z.object({
  id: z.string(),
  userID: z.string(),
  // 質問の内容
  question: z.string(),
  // TODOの質問の内容の回答をAIに渡して、AIが回答した内容
  todosAITextResponseMarkdown: z.string(),
  // TODOのAIの回答のソースとなったもの
  todosGroundings: z.array(GroundingDataSchema),
  // 質問の内容を短く回答したもの
  shortAnswer: z.string(),
  // 質問の内容の対象となるトピック。例) question: 「確定申告の方法」だと「確定申告」
  topic: z.string(),
  // 質問の内容の対象となるトピックについての解説
  definitionAITextResponse: z.string(),
  // TODOのAIの回答のソースとなったもの
  definitionGroundings: z.array(GroundingDataSchema),
  completed: z.boolean().default(false),
});
*/
