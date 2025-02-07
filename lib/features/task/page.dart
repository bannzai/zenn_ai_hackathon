import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todomaker/components/alert/discard.dart';
import 'package:todomaker/components/loading/bot.dart';
import 'package:todomaker/components/grounding_data/list.dart';
import 'package:todomaker/components/todo/list.dart';
import 'package:todomaker/entity/task.dart';
import 'package:todomaker/provider/task.dart';
import 'package:todomaker/provider/todo.dart';

class TaskPage extends HookConsumerWidget {
  final TaskPrepared task;
  const TaskPage({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TaskPageBody(task: task);
  }
}

class TaskPageBody extends HookConsumerWidget {
  final TaskPrepared task;
  const TaskPageBody({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    final topic = task.topic;
    final definitionAITextResponse = task.definitionAITextResponse;
    final todosGroundings = task.todosGroundings;

    final todos = ref.watch(todosProvider(taskID: task.id)).asData?.value ?? [];
    final taskDelete = ref.watch(taskDeleteProvider);
    final taskComplete = ref.watch(taskCompleteProvider);
    final taskRevertComplete = ref.watch(taskRevertCompleteProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(task.question),
        actions: [
          IconButton(
            onPressed: () {
              showDiscardDialog(context, title: '削除', message: 'このタスクを削除しますか？', actions: [
                TextButton(
                  onPressed: () async {
                    await taskDelete(taskID: task.id);
                    if (context.mounted) {
                      Navigator.of(context).pop(true);
                    }
                  },
                  child: const Text('削除'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: const Text('キャンセル'),
                ),
              ]);
            },
            icon: const Icon(Icons.delete),
          ),
          if (todos.isNotEmpty && todos.every((todo) => todo.completedDateTime != null)) ...[
            if (task.completedDateTime == null)
              IconButton(
                onPressed: () async {
                  await taskComplete(taskID: task.id);
                },
                icon: const Icon(Icons.check_box_outline_blank),
              ),
            if (task.completedDateTime != null)
              IconButton(
                onPressed: () async {
                  await taskRevertComplete(taskID: task.id);
                },
                icon: const Icon(Icons.check_box),
              ),
          ],
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(topic, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor)),
                  const SizedBox(height: 10),
                  MarkdownBody(data: definitionAITextResponse),
                  const SizedBox(height: 20),
                  TasksTodoList(task: task),
                  const SizedBox(height: 20),
                  const Divider(height: 1, color: Colors.black),
                  const SizedBox(height: 16),
                  GroundingDataList(groundings: todosGroundings),
                ],
              ),
            ),
            if (task is TaskPreparing) ...[
              const BotLoading(messages: ['準備中...', 'ちょっと待っててね😘', '手順が多いと数分かかることがあるよ☠️', '丁寧にWebから情報を集めてるよ🦾']),
            ],
          ],
        ),
      ),
    );
  }
}
