import 'package:flutter/material.dart';
import 'package:todomaker/entity/task.dart';
import 'package:todomaker/entity/todo.dart';

class TimeRequiredTodos extends StatelessWidget {
  final TaskPrepared task;
  final List<Todo> todos;
  const TimeRequiredTodos({super.key, required this.task, required this.todos});

  @override
  Widget build(BuildContext context) {
    final formattedTotalTimeRequired = todos.formattedTimeRequired;
    if (formattedTotalTimeRequired == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Text('所要時間: $formattedTotalTimeRequired', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
