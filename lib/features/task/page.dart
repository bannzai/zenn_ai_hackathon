import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todomaker/components/alert/discard.dart';
import 'package:todomaker/components/loading/bot.dart';
import 'package:todomaker/components/grounding_data/list.dart';
import 'package:todomaker/components/loading/indicator.dart';
import 'package:todomaker/components/todo/list.dart';
import 'package:todomaker/entity/task.dart';
import 'package:todomaker/features/task/components/location/location.dart';
import 'package:todomaker/provider/task.dart';
import 'package:todomaker/provider/todo.dart';
import 'package:todomaker/style/color.dart';

class TaskPage extends HookConsumerWidget {
  final TaskPrepared task;
  const TaskPage({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final task = ref.watch(taskProvider(taskID: this.task.id)).valueOrNull;
    if (task == null) {
      return const IndicatorPage();
    }
    // FIXME: そのうち.whenとか使う
    return TaskPageBody(task: task as TaskPrepared);
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

    final taskDelete = ref.watch(taskDeleteProvider);
    final taskComplete = ref.watch(taskCompleteProvider);
    final taskRevertComplete = ref.watch(taskRevertCompleteProvider);

    final completed = useState(task.completedDateTime != null);

    final todos = ref.watch(todosProvider(taskID: task.id)).asData?.value ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(task.question),
        actions: [
          IconButton(
            onPressed: () {
              showDiscardDialog(context, title: '削除', message: 'このタスクを削除しますか？', actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    await taskDelete(taskID: task.id);
                  },
                  child: const Text('削除', style: TextStyle(color: TextColor.danger)),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('キャンセル'),
                ),
              ]);
            },
            icon: const Icon(Icons.delete),
          ),
          if (!completed.value)
            IconButton(
              onPressed: () async {
                await taskComplete(taskID: task.id);
                completed.value = true;
              },
              icon: const Icon(Icons.check_box_outline_blank),
            ),
          if (completed.value)
            IconButton(
              onPressed: () async {
                await taskRevertComplete(taskID: task.id);
                completed.value = false;
              },
              icon: const Icon(Icons.check_box),
            ),
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
                  TaskLocation(task: task, todos: todos),
                  const Divider(height: 1, color: Colors.black),
                  const SizedBox(height: 16),
                  GroundingDataList(groundings: todosGroundings),
                ],
              ),
            ),
            if (task is TaskPreparing) ...[
              const BotLoading(messages: ['準備中...', 'ちょっと待っててね😘', '手順が多いと数分かかることがあるよ🏎️', '丁寧にWebから情報を集めてるよ🦾']),
            ],
          ],
        ),
      ),
    );
  }
}
