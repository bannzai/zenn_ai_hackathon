import 'package:flutter/material.dart';
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
          Text('所要時間: $totalTimeRequired 秒', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
