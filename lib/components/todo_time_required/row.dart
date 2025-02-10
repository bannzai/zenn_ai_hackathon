import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todomaker/components/error/error_alert.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:device_calendar/device_calendar.dart';
import 'package:timezone/timezone.dart';

class TodoTimeRequiredRow extends StatelessWidget {
  final Todo todo;
  const TodoTimeRequiredRow({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final formattedTimeRequired = todo.formattedTimeRequired ?? '0秒';
    final formattedUserTimeRequired = todo.formattedUserTimeRequired;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('AIが算出した推定作業時間', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const Spacer(),
              if (formattedUserTimeRequired == null) ...[
                Text(formattedTimeRequired, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
              ],
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(), // これを追加
              ),
              if (formattedUserTimeRequired != null) ...[
                Text(formattedUserTimeRequired, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
              ],
            ],
          ),
          TodoCalendarScheduleSection(todo: todo),
        ],
      ),
    );
  }
}

class TodoCalendarScheduleSection extends HookWidget {
  final Todo todo;
  const TodoCalendarScheduleSection({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
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
            final _calendar = await defaultCalendar();
            events.value = await calendarEvents();
            calendar.value = _calendar;

            showDialog(
              context: context,
              builder: (context) => TodoCaledarScheduleForm(
                todo: todo,
                calendarID: _calendar.id!,
                deviceCalendarPlugin: deviceCalendarPlugin,
                events: events,
              ),
            );

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
                trailing: Icon(Icons.calendar_today),
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
                trailing: Icon(Icons.access_time),
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
                decoration: InputDecoration(labelText: '作業時間 (分)'),
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
                trailing: Icon(Icons.calendar_today),
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
                trailing: Icon(Icons.calendar_today),
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
          child: Text('キャンセル'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text('追加'),
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              if (selectedTime.value == null) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('開始時刻を選択してください')));
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
                  currentDate = currentDate.add(Duration(days: 1));
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
