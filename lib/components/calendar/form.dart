import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todomaker/components/calendar/components/submit_button.dart';
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
    final selectedDate = useState<DateTime?>(null);
    final selectedDays = useState<int>(0);
    final selectedTime = useState<TimeOfDay?>(null);
    final durationStr = useState<String>('');
    final fromDate = useState<DateTime?>(null);
    final toDate = useState<DateTime?>(null);

// - 合計作業時間
// - 開始日
// - 何日間
// - 何時から

    return AlertDialog(
      title: const Text('予定を追加'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // イベント対象日（単発の場合）の選択
            ListTile(
              title: Text(selectedDate.value == null ? '開始日' : '開始日: ${selectedDate.value!.toLocal().toString().split(' ')[0]}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                DateTime initDate = selectedDate.value ?? DateTime.now();
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: initDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (picked != null) {
                  selectedDate.value = picked;
                }
              },
            ),
            // 開始時刻の選択
            ListTile(
              title: Text(selectedTime.value == null ? '何時から' : '何時から: ${selectedTime.value!.format(context)}'),
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
            Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: '日数'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty || int.tryParse(value) == null) {
                      return '日数を入力してください';
                    }
                    return null;
                  },
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {
                    selectedDays.value = int.parse(value);
                  },
                ),

                const SizedBox(height: 10),
                // 作業時間（分）の入力
                TextFormField(
                  decoration: const InputDecoration(labelText: '合計作業時間 (分)'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty || int.tryParse(value) == null) {
                      return '合計作業時間を分単位で入力してください';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    durationStr.value = value;
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: const Text('キャンセル'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TodoCalendarFormSubmitButton(
          deviceCalendarPlugin: deviceCalendarPlugin,
          todo: todo,
          selectedTime: selectedTime,
          durationStr: durationStr,
          fromDate: fromDate,
          toDate: toDate,
          calendarID: calendarID,
          selectedDate: selectedDate,
        ),
      ],
    );
  }
}
