import 'package:flutter/material.dart';
import 'package:todomaker/entity/todo.dart';

class TodoListMemoTile extends StatelessWidget {
  final Todo todo;
  const TodoListMemoTile({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.edit),
      title: const Text('メモ'),
      onTap: () async {},
    );
  }
}
