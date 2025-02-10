import 'package:flutter/material.dart';
import 'package:todomaker/components/todo_locations/row.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:todomaker/style/color.dart';

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
            TodoLocationsSection(todo: todo),
            const Divider(),
          ],
        ],
      ),
    );
  }
}

class TodoLocationsSection extends StatelessWidget {
  final Todo todo;
  const TodoLocationsSection({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final supplement = todo.supplement;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Text(todo.content, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          if (supplement != null && supplement.isNotEmpty) ...[
            Text(
              supplement,
              style: const TextStyle(fontSize: 14, color: TextColor.darkGray),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          TodoLocationsRow(todo: todo),
        ],
      ),
    );
  }
}
