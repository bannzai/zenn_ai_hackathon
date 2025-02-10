import 'package:flutter/material.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:todomaker/utils/picker/time.dart';

class TodoCalendarFormSubmitButton extends StatelessWidget {
  const TodoCalendarFormSubmitButton({
    super.key,
    required this.deviceCalendarPlugin,
    required this.calendarID,
    required this.todo,
    required this.todoCalendarSchedule,
    required this.beginDate,
    required this.selectedTime,
    required this.timeRequired,
    required this.durationDays,
  });

  final DeviceCalendarPlugin deviceCalendarPlugin;
  final String calendarID;
  final Todo todo;
  final TodoCalendarSchedule? todoCalendarSchedule;
  final ValueNotifier<DateTime?> beginDate;
  final ValueNotifier<AppTimeOfDay?> selectedTime;
  final ValueNotifier<int> durationDays;
  final ValueNotifier<AppTimeOfDay> timeRequired;

  @override
  Widget build(BuildContext context) {
    Future<String?> writeEvent({
      required String calendarID,
      required String? eventID,
      required DateTime begin,
      required Duration duration,
      required DateTime recurrenceEnd,
    }) async {
      final event = Event(
        calendarID,
        eventId: eventID,
        title: todo.content,
        allDay: false,
        start: TZDateTime.from(begin, getLocation('Asia/Tokyo')),
        end: TZDateTime.from(begin.add(duration), getLocation('Asia/Tokyo')),
        description: calendarDescription(),
        location: todo.locations?.first.name,
        recurrenceRule: RecurrenceRule(
          RecurrenceFrequency.Daily,
          interval: 1,
          endDate: recurrenceEnd,
        ),
        reminders: [
          Reminder(minutes: 30),
        ],
      );
      final createdEventID = await deviceCalendarPlugin.createOrUpdateEvent(event);
      return createdEventID?.data;
    }

    return TextButton(
      child: const Text('追加'),
      onPressed: () async {
        if (selectedTime.value == null) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('開始時刻を選択してください')));
          return;
        }

        final totalTimeRequiredSeconds = timeRequired.value.hour * 60 * 60 + timeRequired.value.minute * 60;
        final days = durationDays.value;
        final workingTimeSeconds = totalTimeRequiredSeconds ~/ days;

        DateTime eventDate = beginDate.value ?? DateTime.now();
        DateTime eventStart = DateTime(
          eventDate.year,
          eventDate.month,
          eventDate.day,
          selectedTime.value!.hour,
          selectedTime.value!.minute,
        );
        DateTime eventEnd = eventStart.add(Duration(
          days: days,
          seconds: workingTimeSeconds,
        ));

        final eventID = await writeEvent(
          calendarID: calendarID,
          eventID: todoCalendarSchedule?.calendarEventID,
          begin: eventStart,
          duration: Duration(seconds: workingTimeSeconds),
          recurrenceEnd: eventEnd,
        );
        if (context.mounted) {
          Navigator.of(context).pop((eventID, timeRequired.value));
        }
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('カレンダーに追加しました')));
        }
      },
    );
  }

  String calendarDescription() {
    var description = '';
    description += 'TODOMaker で作成したタスクです。\n';
    description += '${todo.content}: ${todo.supplement}\n';
    description += 'AIが算出した推定作業時間: ${todo.formattedTimeRequired}\n';
    description += 'ユーザーが設定した作業時間: ${todo.formattedUserTimeRequired}\n';
    final locations = todo.locations;
    if (locations != null && locations.isNotEmpty) {
      for (final location in locations) {
        description += '関連する位置情報・会場・場所: ${location.name}\n';
        if (location.address != null) {
          description += '住所: ${location.address}\n';
        }
        description += 'https://www.google.com/maps/search/?api=1&query=${location.name}\n';
      }
    }

    return description;
  }
}
