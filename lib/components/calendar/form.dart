import 'package:flutter/material.dart';
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
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final selectedDate = useState<DateTime?>(null);
    final selectedTime = useState<TimeOfDay?>(null);
    final durationStr = useState<String>('');
    final fromDate = useState<DateTime?>(null);
    final toDate = useState<DateTime?>(null);

    /// イベントを追加する関数

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
        TodoCalendarFormSubmitButton(
          formKey: formKey,
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
