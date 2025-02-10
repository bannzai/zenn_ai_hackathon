import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:device_calendar/device_calendar.dart';

class TodoCalendarFormSubmitButton extends StatelessWidget {
  const TodoCalendarFormSubmitButton({
    super.key,
    required this.deviceCalendarPlugin,
    required this.formKey,
    required this.todo,
    required this.selectedTime,
    required this.durationStr,
    required this.fromDate,
    required this.toDate,
    required this.calendarID,
    required this.selectedDate,
  });

  final DeviceCalendarPlugin deviceCalendarPlugin;
  final GlobalKey<FormState> formKey;
  final Todo todo;
  final ValueNotifier<TimeOfDay?> selectedTime;
  final ValueNotifier<String> durationStr;
  final ValueNotifier<DateTime?> fromDate;
  final ValueNotifier<DateTime?> toDate;
  final String calendarID;
  final ValueNotifier<DateTime?> selectedDate;

  @override
  Widget build(BuildContext context) {
    Future<void> writeEvent({
      required String calendarID,
      required String? eventID,
      required DateTime start,
      required DateTime end,
    }) async {
      final event = Event(
        calendarID,
        eventId: eventID,
        title: todo.content,
        allDay: false,
        start: TZDateTime.from(start, getLocation('Asia/Tokyo')),
        end: TZDateTime.from(end, getLocation('Asia/Tokyo')),
        description: calendarDescription(),
        location: todo.locations?.first.name,
        recurrenceRule: RecurrenceRule(
          RecurrenceFrequency.Daily,
          interval: 1,
          endDate: end,
        ),
        reminders: [
          Reminder(minutes: 30),
        ],
      );
      var createdEventID = await deviceCalendarPlugin.createOrUpdateEvent(event);
      if (createdEventID != null) {
        // TODO: イベントを追加したら、イベント一覧を更新する
        // events.value = await calendarEvents();

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('カレンダーに追加しました')));
      }
    }

    return ElevatedButton(
      child: const Text('追加'),
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          if (selectedTime.value == null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('開始時刻を選択してください')));
            return;
          }
          // 入力された作業時間（分）を数値に変換
          int durationMinutes = int.parse(durationStr.value);

          // 繰り返し登録（fromDate と toDate の両方が入力されている場合）
          if (fromDate.value != null && toDate.value != null) {
            DateTime currentDate = fromDate.value!;
            // toDate を含むまでループ
            while (!currentDate.isAfter(toDate.value!)) {
              // 日付と開始時刻を組み合わせてイベント開始時刻を作成
              DateTime eventStart = DateTime(
                currentDate.year,
                currentDate.month,
                currentDate.day,
                selectedTime.value!.hour,
                selectedTime.value!.minute,
              );
              DateTime eventEnd = eventStart.add(Duration(minutes: durationMinutes));
              // イベント作成
              await writeEvent(calendarID: calendarID, eventID: null, start: eventStart, end: eventEnd);
              currentDate = currentDate.add(const Duration(days: 1));
            }
          } else {
            // 単発の予定登録（selectedDate が未選択の場合は本日を使用）
            DateTime eventDate = selectedDate.value ?? DateTime.now();
            DateTime eventStart = DateTime(
              eventDate.year,
              eventDate.month,
              eventDate.day,
              selectedTime.value!.hour,
              selectedTime.value!.minute,
            );
            DateTime eventEnd = eventStart.add(Duration(minutes: durationMinutes));
            await writeEvent(calendarID: calendarID, eventID: null, start: eventStart, end: eventEnd);
          }
          Navigator.of(context).pop();
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
