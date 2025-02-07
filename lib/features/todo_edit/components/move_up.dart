import 'package:flutter/material.dart';
import 'package:todomaker/entity/todo.dart';

class TodoMoveUpListTile extends StatelessWidget {
  final Todo todo;
  const TodoMoveUpListTile({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.arrow_upward),
    );
  }
}
