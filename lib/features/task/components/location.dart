import 'package:flutter/material.dart';
import 'package:todomaker/entity/location.dart';
import 'package:todomaker/entity/task.dart';
import 'package:todomaker/entity/todo.dart';

class TaskLocation extends StatelessWidget {
  final TaskPrepared task;
  final List<Todo> todos;
  const TaskLocation({super.key, required this.task, required this.todos});

  @override
  Widget build(BuildContext context) {
    final locations = task.locations;
    final locationsAITextResponse = task.locationsAITextResponse ?? '';
    final locationsGroundings = task.locationsGroundings ?? [];
    if (locations == null) {
      return TaskLocationEmpty(task: task);
    }

    return Column(
      children: [
        Text(task.topic),
      ],
    );
  }
}

class TaskLocationEmpty extends StatelessWidget {
  final TaskPrepared task;
  const TaskLocationEmpty({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class TaskLocationItem extends StatelessWidget {
  final TaskPrepared task;
  final AppLocation location;
  const TaskLocationItem({
    super.key,
    required this.task,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class TaskLocationTODOLocationList extends StatelessWidget {
  final TaskPrepared task;
  final List<Todo> todos;
  const TaskLocationTODOLocationList({super.key, required this.task, required this.todos});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class TaskLocationTODOLocationItem extends StatelessWidget {
  final TaskPrepared task;
  final Todo todo;
  final AppLocation todoLocation;
  const TaskLocationTODOLocationItem({super.key, required this.task, required this.todo, required this.todoLocation});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
