import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todomaker/components/loading/indicator.dart';
import 'package:todomaker/components/retry/page.dart';
import 'package:todomaker/components/todos/list.dart';
import 'package:todomaker/entity/task.dart';
import 'package:todomaker/provider/task.dart';
import 'package:todomaker/style/color.dart';

class TaskPage extends HookConsumerWidget {
  final String taskID;
  const TaskPage({super.key, required this.taskID});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskProvider(taskID: taskID));

    return Retry(
      retry: () => ref.invalidate(taskProvider(taskID: taskID)),
      child: task.when(
        data: (task) => TaskPageBody(task: task),
        error: (error, stackTrace) => RetryPage(exception: error, stackTrace: stackTrace),
        loading: () => const IndicatorPage(),
      ),
    );
  }
}

class TaskPageBody extends StatelessWidget {
  final Task task;
  const TaskPageBody({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    // Wrap Scaffold
    return Scaffold(
      appBar: AppBar(
        title: Text(task.question),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TasksTodoList(taskID: task.id),
            ],
          ),
        ),
      ),
    );
  }
}
