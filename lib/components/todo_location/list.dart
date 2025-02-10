import 'package:flutter/material.dart';
import 'package:todomaker/entity/todo.dart';

class TODOLocationList extends StatelessWidget {
  final List<Todo> todos;
  const TODOLocationList({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final todo in todos) ...[
          TODOLocationRow(todo: todo),
        ],
      ],
    );
  }
}

class TODOLocationRow extends StatelessWidget {
  final Todo todo;
  const TODOLocationRow({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final supplement = todo.supplement;

    return ListTile(
      title: Text(todo.content),
      subtitle: supplement != null ? Text(supplement) : null,
    );
  }
}
