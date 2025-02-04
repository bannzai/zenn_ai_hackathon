import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todomaker/components/grounding_data/list.dart';
import 'package:todomaker/components/loading/indicator.dart';
import 'package:todomaker/components/retry/page.dart';
import 'package:todomaker/components/todo/list.dart';
import 'package:todomaker/entity/task.dart';
import 'package:todomaker/provider/task.dart';
import 'package:todomaker/style/color.dart';
import 'package:todomaker/utils/network/cloud_run.dart';

class TasksPage extends HookConsumerWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksProvider);

    return Retry(
      retry: () => ref.invalidate(tasksProvider),
      child: tasks.when(
        data: (tasks) => TasksPageBody(tasks: tasks),
        error: (error, stackTrace) => RetryPage(exception: error, stackTrace: stackTrace),
        loading: () => const IndicatorPage(),
      ),
    );
  }
}

class TasksPageBody extends HookConsumerWidget {
  final List<Task> tasks;
  const TasksPageBody({super.key, required this.tasks});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint(tasks.length.toString());
    return Scaffold(
      appBar: AppBar(
        title: const Text('タスク一覧'),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          children: tasks
              .map(
                (task) => Column(
                  children: [
                    TasksPageSection(task: task),
                    const SizedBox(height: 10),
                  ],
                ),
              )
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CloudRunClient.instance.taskCreate(question: '確定申告の方法');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TasksPageSection extends StatelessWidget {
  final Task task;
  const TasksPageSection({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.border),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.question,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              task.definitionAITextResponse,
              style: const TextStyle(fontSize: 14),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 20),
            TasksTodoList(taskID: task.id, limit: 3),
            GroundingDataList(groundings: task.todosGroundings),
          ],
        ),
      ),
    );
  }
}
