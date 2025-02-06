import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todomaker/components/bot_chat.dart';
import 'package:todomaker/components/grounding_data/list.dart';
import 'package:todomaker/components/loading/indicator.dart';
import 'package:todomaker/components/retry/page.dart';
import 'package:todomaker/components/todo/list.dart';
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
    final primaryColor = Theme.of(context).colorScheme.primary;

    final topic = task.topic;
    final definitionAITextResponse = task.definitionAITextResponse;
    final todosGroundings = task.todosGroundings;

    return Scaffold(
      appBar: AppBar(
        title: Text(task.question),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (topic != null) ...[
                    Text(topic, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor)),
                    const SizedBox(height: 10),
                  ],
                  if (definitionAITextResponse != null) ...[
                    MarkdownBody(data: definitionAITextResponse),
                  ],
                  TasksTodoList(taskID: task.id),
                  const SizedBox(height: 20),
                  if (todosGroundings != null) ...[
                    const Divider(height: 1, color: Colors.black),
                    const SizedBox(height: 16),
                    GroundingDataList(groundings: todosGroundings),
                  ],
                ],
              ),
            ),
            if (task is TaskPreparing) ...[
              Positioned.fill(
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Center(
                    child: BotChat(message: '準備中...'),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
