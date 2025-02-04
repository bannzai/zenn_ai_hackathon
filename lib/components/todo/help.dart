import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:todomaker/components/grounding_data/list.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:todomaker/style/color.dart';

class TodoHelpButton extends StatelessWidget {
  final Todo todo;
  const TodoHelpButton({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog(context: context, builder: (context) => TodoHelpDialog(todo: todo));
      },
      icon: const Icon(Icons.help_outline, size: 20),
      // IconButtonは内部でBoxConstraints(minWidth: 48, minHeight: 48)が設定されているので、これをオーバーライドする
      constraints: const BoxConstraints(minWidth: 20, minHeight: 20),
      padding: EdgeInsets.zero,
      style: ButtonStyle(
        padding: WidgetStateProperty.all(EdgeInsets.zero),
      ),
    );
  }
}

class TodoHelpDialog extends StatelessWidget {
  final Todo todo;
  const TodoHelpDialog({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final supplement = todo.supplement;

    final primaryColor = Theme.of(context).colorScheme.primary;

    return AlertDialog(
      title: Column(
        children: [
          Text(todo.content, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          if (supplement != null && supplement.isNotEmpty) ...[
            Text(supplement, style: const TextStyle(fontSize: 14, color: TextColor.darkGray)),
            const SizedBox(height: 10),
          ],
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('詳細', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryColor)),
                  const SizedBox(height: 10),
                  MarkdownBody(data: todo.aiTextResponse),
                ],
              ),
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.black,
          ),
          const SizedBox(height: 10),
          for (final grounding in todo.groundings) GroundingDataList(groundings: [grounding]),
        ],
      ),
      // Default padding is 20;
      contentPadding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 0),
      actionsPadding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('閉じる')),
      ],
    );
  }
}
