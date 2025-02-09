import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:todomaker/components/loading/bot.dart';
import 'package:todomaker/entity/location.dart';
import 'package:todomaker/entity/task.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:todomaker/features/task/components/location/ask.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskLocation extends HookWidget {
  final TaskPrepared task;
  final List<Todo> todos;
  const TaskLocation({super.key, required this.task, required this.todos});

  @override
  Widget build(BuildContext context) {
    final locations = task.locations;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        children: [
          Builder(builder: (context) {
            if (locations == null) {
              return TaskLocationAskAI(task: task);
            }

            return Column(
              children: [
                TaskLocationAskAI(task: task),
                for (final location in locations) ...[
                  TaskLocationItem(task: task, location: location),
                ],
              ],
            );
          }),
          if (false) const BotLoading(messages: ['位置情報を取得中...', '少し待ってね😘', '丁寧にWebから情報を集めてるよ🦾']),
        ],
      ),
    );
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
    final address = location.address;
    final postalCode = location.postalCode;
    final tel = location.tel;
    final email = location.email;
    return Column(
      children: [
        Text(location.name),
        if (address != null) ...[
          Text(location.address ?? ''),
        ],
        if (postalCode != null) ...[
          Text(location.postalCode ?? ''),
        ],
        if (tel != null) ...[
          TextButton(
            onPressed: () => _openPhoneApp(tel: tel),
            child: Text(location.tel ?? ''),
          ),
        ],
        if (email != null) ...[
          TextButton(
            onPressed: () => _openMailApp(mailAddress: email),
            child: Text(location.email ?? ''),
          ),
        ],
      ],
    );
  }

  Future<void> _openPhoneApp({required String tel}) async {
    final telValue = tel.replaceAll(' ', '').replaceAll('-', '');
    final Uri uri = Uri(
      scheme: 'tel',
      path: telValue,
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      final Error error = ArgumentError('Could not launch $uri');
      throw error;
    }
  }

  Future<void> _openMailApp({required String mailAddress}) async {
    final uri = Uri(
      scheme: 'mailto',
      path: mailAddress,
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      final Error error = ArgumentError('Could not launch $uri');
      throw error;
    }
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
