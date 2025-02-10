import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todomaker/components/error/error_alert.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:device_calendar/device_calendar.dart';

class TodoTimeRequiredRow extends StatelessWidget {
  final Todo todo;
  const TodoTimeRequiredRow({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final formattedTimeRequired = todo.formattedTimeRequired ?? '0秒';
    final formattedUserTimeRequired = todo.formattedUserTimeRequired;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('AIの推定所用時間', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const Spacer(),
              if (formattedUserTimeRequired == null) ...[
                Text(formattedTimeRequired, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                const SizedBox(width: 10),
              ],
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit),
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
      if (calendar.value == null) return [];
      DateTime startDate = DateTime.now().subtract(const Duration(days: 30));
      DateTime endDate = DateTime.now().add(const Duration(days: 30));
      var eventsResult = await deviceCalendarPlugin.retrieveEvents(
        calendar.value!.id,
        RetrieveEventsParams(startDate: startDate, endDate: endDate),
      );
      if (eventsResult.isSuccess && eventsResult.data != null) {
        return eventsResult.data!;
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
            (calendar) => calendar.isReadOnly != true,
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
            calendar.value = await defaultCalendar();
            events.value = await calendarEvents();
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
