import 'package:flutter/material.dart';
import 'package:todomaker/components/location/form.dart';
import 'package:todomaker/entity/location.dart';
import 'package:todomaker/entity/task.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:todomaker/utils/functions/firebase_functions.dart';
import 'package:url_launcher/url_launcher.dart';

class TaskLocation extends StatelessWidget {
  final TaskPrepared task;
  final List<Todo> todos;
  const TaskLocation({super.key, required this.task, required this.todos});

  @override
  Widget build(BuildContext context) {
    final locations = task.locations;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Builder(builder: (context) {
        if (locations == null) {
          return TaskLocationEmpty(task: task);
        }

        return Column(
          children: [
            for (final location in locations) ...[
              TaskLocationItem(task: task, location: location),
            ],
          ],
        );
      }),
    );
  }
}

class TaskLocationEmpty extends StatelessWidget {
  final TaskPrepared task;
  const TaskLocationEmpty({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        showDialog(
          context: context,
          builder: (context) => LocationForm(
            onSubmit: (location) async {
              await functions.fillLocation(
                taskID: task.id,
                userLocation: location,
              );
            },
          ),
        );
      },
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.ideographic,
        children: [
          Text('🤖'),
          SizedBox(width: 2),
          Text('関連する位置情報・会場・場所をAIに聞く'),
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

  void _openPhoneApp({required String tel}) {
    _launchURL(
      'tel:$tel',
    );
  }

  void _openMailApp({required String mailAddress}) async {
    return _launchURL(
      'mailto:$mailAddress',
    );
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      final Error error = ArgumentError('Could not launch $url');
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
