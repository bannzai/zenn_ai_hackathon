import 'package:flutter/material.dart';
import 'package:todomaker/components/alert/discard.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:todomaker/style/color.dart';

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
