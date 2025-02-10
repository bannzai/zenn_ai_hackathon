import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todomaker/entity/grounding_data.dart';
import 'package:todomaker/entity/location.dart';
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
    required String? aiTextResponseMarkdown,
    required List<GroundingData>? groundings,
    AppLocation? userLocation,
    List<AppLocation>? locations,
    String? locationsAITextResponse,
    List<GroundingData>? locationsGroundings,
    int? timeRequired,
    String? timeRequiredAITextResponse,
    List<GroundingData>? timeRequiredGroundings,
    @NullableTimestampConverter() DateTime? completedDateTime,
    @ClientCreatedTimestamp() DateTime? createdDateTime,
    @ClientUpdatedTimestamp() DateTime? updatedDateTime,
    @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
    @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}

extension Todos on List<Todo> {
  int get totalTimeRequired {
    return fold(0, (int sum, todo) => sum + (todo.timeRequired ?? 0));
  }

  String? get formattedTimeRequired {
    final totalTimeRequired = this.totalTimeRequired;
    if (totalTimeRequired == 0) {
      return null;
    }
    final duration = Duration(seconds: totalTimeRequired);
    final formattedTimeRequired = duration.inHours > 0
        ? '${duration.inHours}時間 ${duration.inMinutes % 60}分'
        : duration.inMinutes > 0
            ? '${duration.inMinutes}分 ${duration.inSeconds % 60}秒'
            : '${duration.inSeconds}秒';
    return formattedTimeRequired;
  }
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
  // タスクの代表的な場所
  // 未処理の場合はnull。処理完了の場合は空配列の可能性がある
  locations: z.array(LocationSchema).nullable(),
  locationsAITextResponse: z.string().nullable(),
  locationsGroundings: z.array(GroundingDataSchema).nullable(),

  // 所要時間(秒)
  timeRequired: z.number().describe("所要時間(秒)").nullish(),
  timeRequiredAITextResponse: z.string().nullish(),
  timeRequiredGroundings: z.array(GroundingDataSchema).nullish(),
});
*/
