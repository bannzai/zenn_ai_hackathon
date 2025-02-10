import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todomaker/components/error/error_alert.dart';
import 'package:todomaker/components/calendar/form.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:todomaker/provider/todo.dart';

class TodoTimeRequiredRow extends HookConsumerWidget {
  final Todo todo;
  const TodoTimeRequiredRow({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final (timeRequiredTimeOfDay, formattedTimeRequired, isAI) = todo.timeRequiredComponents;
    final timeOfDay = useState(timeRequiredTimeOfDay);
    final todoEditTimeRequired = ref.watch(todoEditTimeRequiredProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(isAI ? '合計作業時間(AI算出)' : '合計作業時間(ユーザー入力)', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const Spacer(),
              Text(formattedTimeRequired, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () async {
                  final value = await showTimePicker(
                    context: context,
                    initialTime: timeOfDay.value,
                    initialEntryMode: TimePickerEntryMode.input,
                  );
                  if (value != null) {
                    timeOfDay.value = value;

                    unawaited(todoEditTimeRequired(
                      taskID: todo.taskID,
                      todoID: todo.id,
                      timeRequired: timeOfDay.value.hour * 60 + timeOfDay.value.minute,
                    ));
                  }
                },
                icon: const Icon(Icons.edit),
                padding: EdgeInsets.zero,
                // NOTE: paddingを消す
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          TodoCalendarScheduleSection(todo: todo),
        ],
      ),
    );
  }
}

class TodoCalendarScheduleSection extends HookConsumerWidget {
  final Todo todo;
  const TodoCalendarScheduleSection({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoSetCalendarSchedule = ref.watch(todoSetCalendarScheduleProvider);
    // device_calendar のインスタンス作成
    final deviceCalendarPlugin = useMemoized(() => DeviceCalendarPlugin());
    // 各種状態を useState で管理
    final calendar = useState<Calendar?>(null);
    final events = useState<List<Event>>([]);

    /// 予定の読み出し（例：過去30日～未来30日）
    Future<List<Event>> calendarEvents() async {
      final calendarValue = calendar.value;
      if (calendarValue == null) return [];
      DateTime startDate = DateTime.now().subtract(const Duration(days: 30));
      DateTime endDate = DateTime.now().add(const Duration(days: 30));
      var eventsResult = await deviceCalendarPlugin.retrieveEvents(
        calendarValue.id,
        RetrieveEventsParams(startDate: startDate, endDate: endDate),
      );
      final eventResultData = eventsResult.data;
      if (eventsResult.isSuccess && eventResultData != null) {
        return eventResultData;
      }
      return [];
    }

    /// カレンダーの初期化（パーミッション要求とカレンダー取得）
    Future<Calendar> defaultCalendar() async {
      var permissionsGranted = await deviceCalendarPlugin.requestPermissions();
      if (permissionsGranted.isSuccess && permissionsGranted.data == true) {
        var calendarsResult = await deviceCalendarPlugin.retrieveCalendars();
        if (calendarsResult.isSuccess && calendarsResult.data != null) {
          // 書き込み可能なカレンダーを自動選択（なければ最初のカレンダー）
          final value = calendarsResult.data!.firstWhere(
            (calendar) => calendar.isDefault ?? false,
            orElse: () => calendarsResult.data!.first,
          );
          return value;
        }
        throw Exception('カレンダーが見つかりません');
      } else {
        throw Exception('カレンダーへのアクセス許可がありません');
      }
    }

    if (todo.calendarSchedules.isEmpty) {
      return TextButton.icon(
        onPressed: () async {
          try {
            final calendar0 = await defaultCalendar();
            final calendarID = calendar0.id;
            if (calendarID == null) {
              throw Exception('カレンダーIDが取得できませんでした');
            }

            events.value = await calendarEvents();
            calendar.value = calendar0;

            if (context.mounted) {
              final result = await showTodoCalendarForm(
                context,
                todo: todo,
                calendarID: calendar0.id!,
                deviceCalendarPlugin: deviceCalendarPlugin,
              );
              if (result != null) {
                final todoCalendarSchedule = TodoCalendarSchedule(calendarID: calendarID, calendarEventID: result.$1);
                final timeRequiredSecond = result.$2.hour * 60 * 60 + result.$2.minute * 60;
                await todoSetCalendarSchedule(
                  taskID: todo.taskID,
                  todoID: todo.id,
                  timeRequired: timeRequiredSecond,
                  todoCalendarSchedule: todoCalendarSchedule,
                );
                events.value = await calendarEvents();
              }
            }

            debugPrint('calendar: ${calendar.value?.id}, events: ${events.value.length}');
          } catch (e) {
            if (context.mounted) {
              showErrorAlert(context, e);
            }
          }
        },
        icon: const Icon(Icons.calendar_month),
        label: const Text('カレンダーに追加'),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
      );
    }
    return Text(todo.calendarSchedules.first.calendarEventID);
  }
}
