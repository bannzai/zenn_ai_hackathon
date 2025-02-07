import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todomaker/components/alert/discard.dart';
import 'package:todomaker/components/grounding_data/list.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:todomaker/provider/todo.dart';

class TodoPage extends HookConsumerWidget {
  final Todo todo;
  const TodoPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supplement = todo.supplement;
    final aiTextResponseMarkdown = todo.aiTextResponseMarkdown;
    final groundings = todo.groundings;

    final primaryColor = Theme.of(context).colorScheme.primary;

    final todoDelete = ref.watch(todoDeleteProvider);
    final todoComplete = ref.watch(todoCompleteProvider);
    final todoRevertComplete = ref.watch(todoRevertCompleteProvider);

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
                    await todoDelete(taskID: todo.taskID, todoID: todo.id);
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
          if (todo.completedDateTime == null)
            IconButton(
              onPressed: () async {
                await todoComplete(taskID: todo.taskID, todoID: todo.id);
              },
              icon: const Icon(Icons.check_box_outline_blank),
            ),
          if (todo.completedDateTime != null)
            IconButton(
              onPressed: () async {
                await todoRevertComplete(taskID: todo.taskID, todoID: todo.id);
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
