import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todomaker/components/alert/discard.dart';
import 'package:todomaker/components/grounding_data/list.dart';
import 'package:todomaker/components/loading/indicator.dart';
import 'package:todomaker/components/retry/page.dart';
import 'package:todomaker/components/todo_locations/ask.dart';
import 'package:todomaker/components/todo_locations/row.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:todomaker/provider/todo.dart';
import 'package:todomaker/style/color.dart';

class TodoPage extends HookConsumerWidget {
  final String taskID;
  final String todoID;
  const TodoPage({super.key, required this.taskID, required this.todoID});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(todoProvider(taskID: taskID, todoID: todoID));
    return Retry(
      retry: () => ref.invalidate(todoProvider(taskID: taskID, todoID: todoID)),
      child: () {
        return todo.when(
          data: (todo) => TodoPageBody(todo: todo),
          error: (e, st) => RetryPage(
            exception: e,
            stackTrace: st,
          ),
          loading: () => const IndicatorPage(),
        );
      }(),
    );
  }
}

class TodoPageBody extends HookConsumerWidget {
  final Todo todo;
  const TodoPageBody({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // FIXME: ここでwatchしなおさないと変更検知できない。そのうち解決する
    final todo = ref.watch(todoProvider(taskID: this.todo.taskID, todoID: this.todo.id)).requireValue;

    final supplement = todo.supplement;
    final aiTextResponseMarkdown = todo.aiTextResponseMarkdown;
    final groundings = todo.groundings;

    final primaryColor = Theme.of(context).colorScheme.primary;

    final todoDelete = ref.watch(todoDeleteProvider);
    final todoComplete = ref.watch(todoCompleteProvider);
    final todoRevertComplete = ref.watch(todoRevertCompleteProvider);

    final completed = useState(todo.completedDateTime != null);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(todo.content, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            onPressed: () {
              showDiscardDialog(context, title: '削除', message: 'このタスクを削除しますか？', actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                    await todoDelete(taskID: todo.taskID, todoID: todo.id);
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
                await todoComplete(taskID: todo.taskID, todoID: todo.id);
                completed.value = true;
              },
              icon: const Icon(Icons.check_box_outline_blank),
            ),
          if (completed.value)
            IconButton(
              onPressed: () async {
                await todoRevertComplete(taskID: todo.taskID, todoID: todo.id);
                completed.value = false;
              },
              icon: const Icon(Icons.check_box),
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(todo.content, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  if (supplement != null && supplement.isNotEmpty) ...[
                    Text(supplement, style: const TextStyle(fontSize: 16)),
                    const SizedBox(height: 10),
                  ],
                ],
              ),
              const SizedBox(height: 20),
              if (aiTextResponseMarkdown != null) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('詳細', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryColor)),
                    const SizedBox(height: 10),
                    MarkdownBody(
                      data: aiTextResponseMarkdown,
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 20),
              const Divider(
                height: 1,
                color: Colors.black,
              ),
              if (todo.locations != null && todo.locations!.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      TodoLocationAskAI(todo: todo),
                      const SizedBox(height: 10),
                      TodoLocationsRow(todo: todo),
                    ],
                  ),
                ),
                const Divider(),
              ],
              if (groundings != null) ...[
                const SizedBox(height: 10),
                GroundingDataList(groundings: groundings),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
