import 'package:flutter/material.dart';
import 'package:todomaker/entity/todo.dart';

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

class TodoCalendarScheduleSection extends StatelessWidget {
  final Todo todo;
  const TodoCalendarScheduleSection({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    if (todo.calendarSchedules.isEmpty) {
      return TextButton.icon(
        onPressed: () {},
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
