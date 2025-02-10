import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:device_calendar/device_calendar.dart';

class TodoCaledarScheduleForm extends HookWidget {
  final Todo todo;
  final String calendarID;
  final DeviceCalendarPlugin deviceCalendarPlugin;
  final ValueNotifier<List<Event>> events;
  const TodoCaledarScheduleForm({
    super.key,
    required this.todo,
    required this.calendarID,
    required this.deviceCalendarPlugin,
    required this.events,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final selectedDate = useState<DateTime?>(null);
    final selectedTime = useState<TimeOfDay?>(null);
    final durationStr = useState<String>('');
    final fromDate = useState<DateTime?>(null);
    final toDate = useState<DateTime?>(null);

    /// イベントを追加する関数
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
      }
    }

    return AlertDialog(
      title: const Text('予定を追加'),
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // イベント対象日（単発の場合）の選択
              ListTile(
                title: Text(selectedDate.value == null ? '日付を選択' : '日付: ${selectedDate.value!.toLocal().toString().split(' ')[0]}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime initDate = selectedDate.value ?? DateTime.now();
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: initDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    selectedDate.value = picked;
                  }
                },
              ),
              // 開始時刻の選択
              ListTile(
                title: Text(selectedTime.value == null ? '開始時刻を選択' : '開始時刻: ${selectedTime.value!.format(context)}'),
                trailing: const Icon(Icons.access_time),
                onTap: () async {
                  TimeOfDay initTime = selectedTime.value ?? TimeOfDay.now();
                  final TimeOfDay? picked = await showTimePicker(
                    context: context,
                    initialTime: initTime,
                  );
                  if (picked != null) {
                    selectedTime.value = picked;
                  }
                },
              ),
              // 作業時間（分）の入力
              TextFormField(
                decoration: const InputDecoration(labelText: '作業時間 (分)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return '作業時間を分単位で入力してください';
                  }
                  return null;
                },
                onChanged: (value) {
                  durationStr.value = value;
                },
              ),
              // オプション：繰り返し開始日の選択
              ListTile(
                title: Text(fromDate.value == null ? '繰り返し開始日 (任意)' : '繰り返し開始日: ${fromDate.value!.toLocal().toString().split(' ')[0]}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime initDate = fromDate.value ?? DateTime.now();
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: initDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    fromDate.value = picked;
                  }
                },
              ),
              // オプション：繰り返し終了日の選択
              ListTile(
                title: Text(toDate.value == null ? '繰り返し終了日 (任意)' : '繰り返し終了日: ${toDate.value!.toLocal().toString().split(' ')[0]}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  DateTime initDate = toDate.value ?? DateTime.now();
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: initDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    toDate.value = picked;
                  }
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text('キャンセル'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
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
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            }
          },
        ),
      ],
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
