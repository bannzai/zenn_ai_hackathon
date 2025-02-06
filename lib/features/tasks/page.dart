import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todomaker/components/loading/bot.dart';
import 'package:todomaker/components/grounding_data/list.dart';
import 'package:todomaker/components/loading/indicator.dart';
import 'package:todomaker/components/retry/page.dart';
import 'package:todomaker/components/todo/list.dart';
import 'package:todomaker/entity/task.dart';
import 'package:todomaker/features/task/page.dart';
import 'package:todomaker/provider/task.dart';
import 'package:todomaker/style/color.dart';
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
          functions.taskCreate(question: '確定申告の方法');
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

    final definitionAITextResponse = task.definitionAITextResponse;
    final todosGroundings = task.todosGroundings;

    return Stack(
      children: [
        Padding(
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
                Row(
                  children: [
                    Text(
                      task.question,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPage(taskID: task.id)));
                      },
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('詳細を見る', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: TextColor.link)),
                          SizedBox(width: 2),
                          Icon(Icons.chevron_right, color: TextColor.link, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                if (definitionAITextResponse != null) ...[
                  Text(
                    definitionAITextResponse,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 10),
                ],
                const Divider(height: 1, color: Colors.black),
                const SizedBox(height: 20),
                TasksTodoList(taskID: task.id, limit: 3),
                const Divider(height: 1, color: Colors.black),
                const SizedBox(height: 16),
                if (todosGroundings != null) ...[
                  GroundingDataList(groundings: todosGroundings),
                ],
              ],
            ),
          ),
        ),
        if (task is TaskPreparing) ...[
          const BotLoading(message: '準備中...'),
        ],
      ],
    );
  }
}
