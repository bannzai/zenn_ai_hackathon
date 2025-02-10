import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:todomaker/entity/grounding_data.dart';
import 'package:todomaker/entity/location.dart';
import 'package:todomaker/entity/timestamp.dart';
import 'package:todomaker/utils/picker/time.dart';

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
    int? userTimeRequired,
    @Default([]) List<TodoCalendarSchedule> calendarSchedules,
    @NullableTimestampConverter() DateTime? completedDateTime,
    @ClientCreatedTimestamp() DateTime? createdDateTime,
    @ClientUpdatedTimestamp() DateTime? updatedDateTime,
    @ServerCreatedTimestamp() DateTime? serverCreatedDateTime,
    @ServerUpdatedTimestamp() DateTime? serverUpdatedDateTime,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);

  AppTimeOfDay get timeRequiredTimeOfDay {
    final timeRequired = this.timeRequired;
    if (timeRequired == null) {
      return AppTimeOfDay(hour: 0, minute: 0);
    }
    if (timeRequired <= 60) {
      return AppTimeOfDay(hour: 0, minute: 1);
    }

    final duration = Duration(seconds: timeRequired);
    return AppTimeOfDay(hour: duration.inHours, minute: duration.inMinutes % 60);
  }

  String get formattedTimeRequired {
    final hour = timeRequiredTimeOfDay.hour;
    final minute = timeRequiredTimeOfDay.minute;
    final String hourString;
    final String minuteString;
    if (hour < 10) {
      hourString = '0$hour';
    } else {
      hourString = hour.toString();
    }
    if (minute < 10) {
      minuteString = '0$minute';
    } else {
      minuteString = minute.toString();
    }
    return '$hourString:$minuteString';
  }

  AppTimeOfDay get userTimeRequiredTimeOfDay {
    final userTimeRequired = this.userTimeRequired;
    if (userTimeRequired == null) {
      return AppTimeOfDay(hour: 0, minute: 0);
    }
    if (userTimeRequired <= 60) {
      return AppTimeOfDay(hour: 0, minute: 1);
    }
    final duration = Duration(seconds: userTimeRequired);
    return AppTimeOfDay(hour: duration.inHours, minute: duration.inMinutes % 60);
  }

  String get formattedUserTimeRequired {
    final hour = userTimeRequiredTimeOfDay.hour;
    final minute = userTimeRequiredTimeOfDay.minute;
    final String hourString;
    final String minuteString;
    if (hour < 10) {
      hourString = '0$hour';
    } else {
      hourString = hour.toString();
    }
    if (minute < 10) {
      minuteString = '0$minute';
    } else {
      minuteString = minute.toString();
    }
    return '$hourString:$minuteString';
  }

  (AppTimeOfDay, String, bool) get timeRequiredComponents {
    final userTimeRequired = this.userTimeRequired;
    final isAI = userTimeRequired == null;
    if (isAI) {
      return (timeRequiredTimeOfDay, formattedTimeRequired, isAI);
    }
    return (userTimeRequiredTimeOfDay, formattedUserTimeRequired, isAI);
  }
}

extension Todos on List<Todo> {
  int get totalTimeRequired {
    return fold(0, (int sum, todo) => sum + (todo.timeRequired ?? 0));
  }

  String get formattedTimeRequired {
    var list = <AppTimeOfDay>[];
    for (final todo in this) {
      final AppTimeOfDay timeOfDay;
      if (todo.userTimeRequired == null) {
        timeOfDay = todo.timeRequiredTimeOfDay;
      } else {
        timeOfDay = todo.userTimeRequiredTimeOfDay;
      }
      list.add(timeOfDay);
    }
    final summarizedForMinutes = list.fold(
      0,
      (int sum, timeOfDay) => sum + timeOfDay.minute + timeOfDay.hour * 60,
    );
    final totalHour = summarizedForMinutes ~/ 60;
    final totalMinute = summarizedForMinutes % 60;

    final String totalHourString;
    final String totalMinuteString;
    if (totalHour < 10) {
      totalHourString = '0$totalHour';
    } else {
      totalHourString = totalHour.toString();
    }
    if (totalMinute < 10) {
      totalMinuteString = '0$totalMinute';
    } else {
      totalMinuteString = totalMinute.toString();
    }
    return '$totalHourString:$totalMinuteString';
  }
}

@freezed
class TodoCalendarSchedule with _$TodoCalendarSchedule {
  const factory TodoCalendarSchedule({
    required String calendarID,
    required String calendarEventID,
  }) = _TodoCalendarSchedule;

  factory TodoCalendarSchedule.fromJson(Map<String, dynamic> json) => _$TodoCalendarScheduleFromJson(json);
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
