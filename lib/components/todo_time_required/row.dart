import 'package:flutter/material.dart';
import 'package:todomaker/entity/todo.dart';

class TodoTimeRequiredRow extends StatelessWidget {
  final Todo todo;
  const TodoTimeRequiredRow({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(todo.timeRequired.toString()),
      ],
    );
  }
}
