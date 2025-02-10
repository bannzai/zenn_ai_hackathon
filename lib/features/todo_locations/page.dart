import 'package:flutter/material.dart';
import 'package:todomaker/components/todo_locations/list.dart';
import 'package:todomaker/entity/todo.dart';

class TodoLocationsPage extends StatelessWidget {
  final List<Todo> todos;
  const TodoLocationsPage({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('関連場所一覧'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: TodoLocationList(todos: todos),
        ),
      ),
    );
  }
}
