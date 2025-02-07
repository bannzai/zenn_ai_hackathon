import 'package:flutter/material.dart';
import 'package:todomaker/entity/todo.dart';

class TodoMoveDownListTile extends StatelessWidget {
  final Todo todo;
  const TodoMoveDownListTile({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.arrow_downward),
    );
  }
}
