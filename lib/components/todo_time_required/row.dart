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
        events.value = await calendarEvents();
      }
    }

    if (todo.calendarSchedules.isEmpty) {
      return TextButton.icon(
        onPressed: () async {
          try {
            calendar.value = await defaultCalendar();
            events.value = await calendarEvents();

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
