import 'package:cloud_firestore/cloud_firestore.dart';
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
    required String shortAnswer,
    required String topic,
    required String definition,
    required String todoAITextResponse,
    required List<GroundingData> todoGroundings,
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
  // 質問の内容
  question: z.string(),
  // TODOの質問の内容の回答をAIに渡して、AIが回答した内容
  todoAITextResponse: z.string(),
  // TODOのAIの回答のソースとなったもの
  todoGroundings: z.array(GroundingDataSchema),
  // 質問の内容を短く回答したもの
  shortAnswer: z.string(),
  // 質問の内容の対象となるトピック。例) question: 「確定申告の方法」だと「確定申告」
  topic: z.string(),
  // 質問の内容の対象となるトピックについての解説
  definition: z.string(),
  completed: z.boolean().default(false),
});

*/
