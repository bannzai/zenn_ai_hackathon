import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todomaker/entity/grounding_data.dart';
import 'package:todomaker/entity/location.dart';
import 'package:todomaker/entity/timestamp.dart';

part 'task.g.dart';
part 'task.freezed.dart';

@Freezed(unionKey: 'status')
sealed class Task with _$Task {
  const Task._();

  @JsonSerializable(explicitToJson: true)
  const factory Task.prepared({
    required String id,
    required String userID,
    required String question,
    required String todosAITextResponseMarkdown,
    required List<GroundingData> todosGroundings,
    required String shortAnswer,
    required String topic,
    required String definitionAITextResponse,
    required List<GroundingData> definitionGroundings,
    List<AppLocation>? locations,
    String? locationsAITextResponse,
    List<GroundingData>? locationsGroundings,
    @NullableTimestampConverter() required DateTime? preparedDateTime,
    @NullableTimestampConverter() required DateTime? completedDateTime,
    @ClientCreatedTimestamp() DateTime? createdDateTime,
    @ClientUpdatedTimestamp() DateTime? updatedDateTime,
    @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
    @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime,
  }) = TaskPrepared;

  @JsonSerializable(explicitToJson: true)
  const factory Task.preparing({
    required String id,
    required String userID,
    required String question,
    String? todosAITextResponseMarkdown,
    List<GroundingData>? todosGroundings,
    String? shortAnswer,
    String? topic,
    String? definitionAITextResponse,
    List<GroundingData>? definitionGroundings,
    @ClientCreatedTimestamp() DateTime? createdDateTime,
    @ClientUpdatedTimestamp() DateTime? updatedDateTime,
    @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
    @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime,
  }) = TaskPreparing;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

/*
import { z } from "zod";
import { GroundingDataSchema } from "./grounding";
import {
  FirestoreTimestampSchema,
  ServerTimestampSchema,
} from "./util/timestamp";

export const TaskPreparedSchema = z
  .object({
    status: z.literal("prepared"),
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
    // タスクの代表的な場所
    // 未処理の場合はnull。処理完了の場合は空配列の可能性がある
    locations: z.array(LocationSchema).nullable(),
    locationsAITextResponse: z.string().nullable(),
    locationsGroundings: z.array(GroundingDataSchema).nullable(),

    fullFilledDateTime: FirestoreTimestampSchema,
  })
  .merge(ServerTimestampSchema);

export const TaskPreparingSchema = TaskPreparedSchema.partial()
  .required({
    id: true,
    userID: true,
    question: true,
    serverCreatedDateTime: true,
    serverUpdatedDateTime: true,
  })
  .omit({
    fullFilledDateTime: true,
    completed: true,
  })
  .merge(
    z.object({
      status: z.literal("preparing"),
    })
  );
export const TaskSchema = z.union([TaskPreparedSchema, TaskPreparingSchema]);

export type Task = z.infer<typeof TaskSchema>;
export type TaskPrepared = z.infer<typeof TaskPreparedSchema>;
export type TaskPreparing = z.infer<typeof TaskPreparingSchema>;
})*/
