import 'package:flutter/material.dart';
import 'package:todomaker/components/alert/help.dart';
import 'package:todomaker/entity/todo.dart';

class TodoHelpButton extends StatelessWidget {
  final Todo todo;
  const TodoHelpButton({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final aiTextResponseMarkdown = todo.aiTextResponseMarkdown;
    final groundings = todo.groundings;
    if (aiTextResponseMarkdown == null || groundings == null) {
      return const SizedBox.shrink();
    }
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => HelpAlertLayout(
            title: todo.content,
            subtitle: todo.supplement,
            detailMarkdown: aiTextResponseMarkdown,
            groundings: groundings,
          ),
        );
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
