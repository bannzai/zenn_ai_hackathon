import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todomaker/components/error/error_alert.dart';
import 'package:todomaker/components/calendar/form.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:todomaker/provider/todo.dart';
import 'package:todomaker/components/todo_time_required/functions.dart';
import 'package:todomaker/utils/picker/time.dart';

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
                  final value = await showAppTimePicker(
                    context,
                    initialTime: timeOfDay.value,
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
          const SizedBox(height: 10),
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
    final deviceCalendarPlugin = useMemoized(() => DeviceCalendarPlugin());
    final calendars = useState<List<Calendar>>([]);
    final calendar = useState<Calendar?>(null);
    final events = useState<List<Event>>([]);
    final hasPermission = useState<bool>(false);

    useEffect(() {
      Future<void> f() async {
        hasPermission.value = (await deviceCalendarPlugin.hasPermissions()).data == true;
      }

      f();

      return null;
    }, []);

    if (!hasPermission.value) {
      return TodoCalendarScheduleHasNoPermissionButton(
        deviceCalendarPlugin: deviceCalendarPlugin,
        hasPermission: hasPermission,
      );
    } else {
      return TodoCalendarScheduleButtons(
        todo: todo,
        deviceCalendarPlugin: deviceCalendarPlugin,
        todoSetCalendarSchedule: todoSetCalendarSchedule,
        calendars: calendars,
        events: events,
        calendar: calendar,
      );
    }
  }
}

class TodoCalendarScheduleHasNoPermissionButton extends HookWidget {
  const TodoCalendarScheduleHasNoPermissionButton({
    super.key,
    required this.deviceCalendarPlugin,
    required this.hasPermission,
  });

  final DeviceCalendarPlugin deviceCalendarPlugin;
  final ValueNotifier<bool> hasPermission;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () async {
        try {
          hasPermission.value = await grandPermission(deviceCalendarPlugin: deviceCalendarPlugin);
          if (!hasPermission.value) {
            throw Exception('カレンダーへのアクセス許可がありません');
          }
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
}

class TodoCalendarScheduleButtons extends HookConsumerWidget {
  const TodoCalendarScheduleButtons({
    super.key,
    required this.todo,
    required this.deviceCalendarPlugin,
    required this.todoSetCalendarSchedule,
    required this.calendars,
    required this.events,
    required this.calendar,
  });

  final Todo todo;
  final DeviceCalendarPlugin deviceCalendarPlugin;
  final TodoSetCalendarSchedule todoSetCalendarSchedule;
  final ValueNotifier<List<Calendar>> calendars;
  final ValueNotifier<List<Event>> events;
  final ValueNotifier<Calendar?> calendar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(() {
      Future<void> f() async {
        // FIXME: カレンダーを大量に出すとよくわからなくなったのでデフォルトのカレンダーを選択させる
        // calendars.value = await retrieveCalendars(deviceCalendarPlugin: deviceCalendarPlugin);
        final result = await retrieveCalendars(deviceCalendarPlugin: deviceCalendarPlugin);
        calendars.value = result.where((e) => e.isDefault == true).toList();
      }

      f();
      return null;
    }, []);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final calendar in calendars.value) ...[
          TodoCalendarScheduleButton(
            todo: todo,
            deviceCalendarPlugin: deviceCalendarPlugin,
            todoSetCalendarSchedule: todoSetCalendarSchedule,
            calendar: calendar,
          ),
        ],
      ],
    );
  }
}

class TodoCalendarScheduleButton extends HookConsumerWidget {
  const TodoCalendarScheduleButton({
    super.key,
    required this.todo,
    required this.deviceCalendarPlugin,
    required this.todoSetCalendarSchedule,
    required this.calendar,
  });

  final Todo todo;
  final DeviceCalendarPlugin deviceCalendarPlugin;
  final TodoSetCalendarSchedule todoSetCalendarSchedule;
  final Calendar calendar;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = useState<List<Event>>([]);
    useEffect(() {
      Future<void> f() async {
        events.value = await calendarEvents(
          todo: todo,
          calendar: calendar,
          deviceCalendarPlugin: deviceCalendarPlugin,
        );
      }

      f();
      return null;
    }, []);

    return TextButton.icon(
      onPressed: () async {
        try {
          final calendarID = calendar.id;
          if (calendarID == null) {
            throw Exception('カレンダーIDが取得できませんでした');
          }

          if (context.mounted) {
            final result = await showTodoCalendarForm(
              context,
              todo: todo,
              calendarID: calendarID,
              deviceCalendarPlugin: deviceCalendarPlugin,
            );
            debugPrint('showTodoCalendarForm.result: $result');
            if (result != null) {
              final todoCalendarSchedule = TodoCalendarSchedule(calendarID: calendarID, calendarEventID: result.$1);
              final timeRequiredSecond = result.$2.hour * 60 * 60 + result.$2.minute * 60;
              await todoSetCalendarSchedule(
                taskID: todo.taskID,
                todoID: todo.id,
                timeRequired: timeRequiredSecond,
                todoCalendarSchedule: todoCalendarSchedule,
              );
              events.value = await calendarEvents(
                todo: todo,
                calendar: calendar,
                deviceCalendarPlugin: deviceCalendarPlugin,
              );
            }
          }

          debugPrint('calendar: ${calendar.id}, events: ${events.value.length}');
        } catch (e) {
          if (context.mounted) {
            showErrorAlert(context, e);
          }
        }
      },
      icon: const Icon(Icons.calendar_month),
      label: Text('${calendar.name ?? calendar.accountType}に追加'),
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
    );
  }
}
