import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todomaker/components/alert/discard.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:todomaker/style/color.dart';

class TodoEllipsis extends HookConsumerWidget {
  final Todo todo;
  const TodoEllipsis({super.key, required this.todo});

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

class TodoListMemoTile extends StatelessWidget {
  final Todo todo;
  const TodoListMemoTile({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.edit),
      title: const Text('メモ'),
      onTap: () async {},
    );
  }
}

class TodoDeleteListTile extends StatelessWidget {
  final Todo todo;
  const TodoDeleteListTile({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.delete),
      title: const Text(
        '削除',
        style: TextStyle(color: TextColor.danger),
      ),
      onTap: () async {
        showDiscardDialog(
          context,
          title: '削除',
          message: '本当に削除しますか？',
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('削除'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('キャンセル'),
            ),
          ],
        );
      },
    );
  }
}

class TodoMoveUpListTile extends StatelessWidget {
  final Todo todo;
  const TodoMoveUpListTile({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.arrow_upward),
    );
  }
}

class TodoMoveDownListTile extends StatelessWidget {
  final Todo todo;
  const TodoMoveDownListTile({
    super.key,
    required this.todo,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.arrow_downward),
    );
  }
}
