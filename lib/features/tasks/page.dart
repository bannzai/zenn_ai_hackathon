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
          'TODOMakerアシスタントです',
          'やることを自動でまとめてくれるよ',
          '右下の + ボタンから聞いてね',
          '例えば「確定申告の方法」',
          '「結婚の手続き」などなど',
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
    return ListView(
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
    );
  }
}
