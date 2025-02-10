import 'package:flutter/material.dart';
import 'package:todomaker/components/todo_time_required/row.dart';
import 'package:todomaker/entity/task.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:todomaker/style/color.dart';

class TimeRequiredTodos extends StatelessWidget {
  final TaskPrepared task;
  final List<Todo> todos;
  const TimeRequiredTodos({super.key, required this.task, required this.todos});

  @override
  Widget build(BuildContext context) {
    final formattedTotalTimeRequired = todos.formattedTimeRequired;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('合計作業時間: $formattedTotalTimeRequired', style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          TodoTimeRequiredListLink(todos: todos),
        ],
      ),
    );
  }
}

class TodoTimeRequiredSection extends StatelessWidget {
  final Todo todo;
  const TodoTimeRequiredSection({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final supplement = todo.supplement;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          const SizedBox(height: 10),
          TodoTimeRequiredRow(todo: todo),
        ],
      ),
    );
  }
}

class TodoTimeRequiredListPage extends StatelessWidget {
  final List<Todo> todos;
  const TodoTimeRequiredListPage({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('関連場所一覧'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: TodoTimeRequiredList(todos: todos),
        ),
      ),
    );
  }
}

class TodoTimeRequiredList extends StatelessWidget {
  final List<Todo> todos;
  const TodoTimeRequiredList({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final todo in todos) ...[
            TodoTimeRequiredSection(todo: todo),
            const Divider(),
          ],
        ],
      ),
    );
  }
}

class TodoTimeRequiredListLink extends StatelessWidget {
  final List<Todo> todos;
  const TodoTimeRequiredListLink({super.key, required this.todos});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TodoTimeRequiredListPage(todos: todos))),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('作業時間内訳', style: TextStyle(color: TextColor.secondaryLink)),
          Icon(Icons.chevron_right, color: TextColor.secondaryLink),
        ],
      ),
    );
  }
}
