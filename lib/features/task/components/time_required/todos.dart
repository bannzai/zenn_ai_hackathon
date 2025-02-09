import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todomaker/entity/task.dart';
import 'package:todomaker/entity/todo.dart';

class TimeRequiredTodos extends StatelessWidget {
  final TaskPrepared task;
  final List<Todo> todos;
  const TimeRequiredTodos({super.key, required this.task, required this.todos});

  @override
  Widget build(BuildContext context) {
    final totalTimeRequired = todos.fold(0, (sum, todo) => sum + (todo.timeRequired ?? 0));
    if (totalTimeRequired == 0) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text('所要時間: ${_formatted(totalTimeRequired)} 秒', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  String _formatted(int seconds) {
    final duration = Duration(seconds: seconds);
    final formattedTimeRequired = duration.inHours > 0
        ? '${duration.inHours}時間 ${duration.inMinutes % 60}分'
        : duration.inMinutes > 0
            ? '${duration.inMinutes}分 ${duration.inSeconds % 60}秒'
            : '${duration.inSeconds}秒';
    return formattedTimeRequired;
  }
}
