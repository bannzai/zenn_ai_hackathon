import 'package:flutter/material.dart';
import 'package:todomaker/components/todo_location/list.dart';
import 'package:todomaker/entity/todo.dart';

class TodoLocationList extends StatelessWidget {
  final List<Todo> todos;
  const TodoLocationList({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final todo in todos) ...[
            TodoLocationRow(todo: todo),
            const Divider(),
          ],
        ],
      ),
    );
  }
}
