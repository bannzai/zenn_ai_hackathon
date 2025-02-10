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

  const TodoCaledarScheduleForm({
    super.key,
    required this.todo,
    required this.calendarID,
    required this.deviceCalendarPlugin,
  });

  @override
  Widget build(BuildContext context) {
    final beginDate = useState<DateTime>(DateTime.now());
    final selectedDays = useState<int>(1);
    final selectedTime = useState<TimeOfDay>(TimeOfDay.now());
    final durationMinutes = useState<int>(todo.userTimeRequired ?? todo.timeRequired ?? 0);

    return AlertDialog(
      title: const Text('予定を追加'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // イベント対象日（単発の場合）の選択
            ListTile(
              title: Text('開始日: ${beginDate.value.toLocal().toString().split(' ')[0]}'),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: beginDate.value,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (picked != null) {
                  beginDate.value = picked;
                }
              },
            ),
            // 開始時刻の選択
            ListTile(
              title: Text('何時から: ${selectedTime.value.format(context)}'),
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: selectedTime.value,
                );
                if (picked != null) {
                  selectedTime.value = picked;
                }
              },
            ),
            Column(
              children: [
                Row(
                  children: [
                    const Text('日数'),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SizedBox(
                        height: 60,
                        child: TextFormField(
                          initialValue: selectedDays.value.toString(),
                          decoration: const InputDecoration(hintText: '日数'),
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
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),
                // 作業時間（分）の入力
                Row(
                  children: [
                    const Text('合計作業時間'),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(hintText: '分'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                        validator: (value) {
                          if (value == null || value.isEmpty || int.tryParse(value) == null) {
                            return '合計作業時間を分単位で入力してください';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          durationMinutes.value = int.parse(value);
                        },
                      ),
                    ),
                  ],
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
            Navigator.of(context).pop(null);
          },
        ),
        TodoCalendarFormSubmitButton(
          deviceCalendarPlugin: deviceCalendarPlugin,
          todo: todo,
          selectedTime: selectedTime,
          calendarID: calendarID,
          beginDate: beginDate,
          durationMinutes: durationMinutes,
          durationDays: selectedDays,
        ),
      ],
    );
  }
}

// return eventID or null
Future<String?> showTodoCalendarForm(
  BuildContext context, {
  required Todo todo,
  required String calendarID,
  required DeviceCalendarPlugin deviceCalendarPlugin,
}) async {
  return await showDialog<String?>(
    context: context,
    builder: (context) => TodoCaledarScheduleForm(
      todo: todo,
      calendarID: calendarID,
      deviceCalendarPlugin: deviceCalendarPlugin,
    ),
  );
}
