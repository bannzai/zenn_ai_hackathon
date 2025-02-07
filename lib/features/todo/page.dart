import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todomaker/components/grounding_data/list.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:todomaker/style/color.dart';

class TodoPage extends HookConsumerWidget {
  final Todo todo;
  const TodoPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supplement = todo.supplement;

    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Column(
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
                  MarkdownBody(data: todo.aiTextResponseMarkdown),
                ],
              ),
            ),
          ),
          const Divider(
            height: 1,
            color: Colors.black,
          ),
          const SizedBox(height: 10),
          GroundingDataList(groundings: todo.groundings),
        ],
      ),
    );
  }
}
