import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todomaker/components/error/error_alert.dart';
import 'package:todomaker/components/form/question_form.dart';
import 'package:todomaker/components/loading/bot.dart';
import 'package:todomaker/components/loading/indicator.dart';
import 'package:todomaker/components/retry/page.dart';
import 'package:todomaker/entity/task.dart';
import 'package:todomaker/features/tasks/components/section.dart';
import 'package:todomaker/provider/task.dart';
import 'package:todomaker/utils/functions/firebase_functions.dart';

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
    final taskCreate = ref.watch(taskCreateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('やること一覧'),
      ),
      body: SafeArea(
        child: tasks.isEmpty ? const TasksPageBodyEmpty() : TasksPageBodyListView(tasks: tasks),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final question = await showQuestionFormSheet(context);
          if (question != null) {
            try {
              final task = await taskCreate(question: question);
              await functions.enqueueTaskCreate(taskID: task.id, question: question);
            } catch (e) {
              if (context.mounted) {
                showErrorAlert(context, e);
              }
            }
          }
        },
        child: const Text('🤖', style: TextStyle(fontSize: 24)),
      ),
    );
  }
}

class TasksPageBodyEmpty extends HookConsumerWidget {
  const TasksPageBodyEmpty({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Center(
      child: BotChat(
        messages: [
          'こんにちは',
          'TODOMakerです',
          '行動の手順を作成します',
          '右下の 🤖 ボタンから質問してね',
          '例えば「確定申告の方法」',
          '「結婚の手続き」などなど',
          'あなたの代わりにTODOリストを作成します',
        ],
      ),
    );
  }
}

class TasksPageBodyListView extends HookConsumerWidget {
  final List<Task> tasks;
  const TasksPageBodyListView({super.key, required this.tasks});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final doneTasks = tasks.where((task) => task is TaskPrepared && task.completedDateTime != null).toList();
    final undoneTasks = tasks.whereNot((task) => doneTasks.contains(task)).toList();
    return ListView(padding: const EdgeInsets.symmetric(vertical: 20.0), children: [
      for (var task in undoneTasks)
        Column(
          children: [
            TasksPageSection(task: task),
            const SizedBox(height: 10),
          ],
        ),
      if (undoneTasks.isNotEmpty && doneTasks.isNotEmpty) ...[
        const Divider(),
        const SizedBox(height: 10),
      ],
      if (doneTasks.isNotEmpty) ...[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Text('完了済み', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        ),
        const SizedBox(height: 10),
        for (var task in doneTasks)
          Column(
            children: [
              TasksPageSection(task: task),
              const SizedBox(height: 10),
            ],
          ),
      ],
    ]);
  }
}
