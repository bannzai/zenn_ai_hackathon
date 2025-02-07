import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todomaker/components/todo/ellipsis.dart';
import 'package:todomaker/entity/todo.dart';

class TodoEditPage extends HookConsumerWidget {
  final Todo todo;
  const TodoEditPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeData = Theme.of(context);
    final primaryColor = themeData.colorScheme.primary;
    final titleTextStyle = themeData.listTileTheme.titleTextStyle?.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w700,
    );
    return Theme(
      data: themeData.copyWith(
        listTileTheme: themeData.listTileTheme.copyWith(
          iconColor: primaryColor,
          titleTextStyle: titleTextStyle,
        ),
      ),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(bottom: 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TodoListMemoTile(todo: todo),
            TodoDeleteListTile(todo: todo),
            TodoMoveUpListTile(todo: todo),
            TodoMoveDownListTile(todo: todo),
          ],
        ),
      ),
    );
  }
}