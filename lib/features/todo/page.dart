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
        centerTitle: true,
        title: Text(todo.content, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        // title: RichText(
        //   textAlign: TextAlign.center,
        //   text: TextSpan(
        //     children: [
        //       TextSpan(text: '${todo.content}\n', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        //       if (supplement != null && supplement.isNotEmpty) ...[
        //         TextSpan(text: supplement, style: const TextStyle(fontSize: 10)),
        //       ],
        //     ],
        //   ),
        // ),
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('詳細', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryColor)),
                  const SizedBox(height: 10),
                  MarkdownBody(
                    data: todo.aiTextResponseMarkdown,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(
                height: 1,
                color: Colors.black,
              ),
              const SizedBox(height: 10),
              GroundingDataList(groundings: todo.groundings),
            ],
          ),
        ),
      ),
    );
  }
}
