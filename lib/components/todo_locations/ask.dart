import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todomaker/components/error/error_alert.dart';
import 'package:todomaker/components/location/form.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:todomaker/provider/todo.dart';
import 'package:todomaker/utils/functions/firebase_functions.dart';

class TodoLocationAskAI extends HookConsumerWidget {
  final Todo todo;
  const TodoLocationAskAI({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoFillLocation = ref.watch(todoFillLocationProvider);
    final locations = todo.locations;

    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 0),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: Size.zero,
      ),
      onPressed: () async {
        showDialog(
          context: context,
          builder: (context) => LocationForm(
            onSubmit: (userLocation) async {
              try {
                await todoFillLocation(
                  taskID: todo.taskID,
                  todoID: todo.id,
                  userLocation: userLocation,
                );
                await functions.fillTodoLocation(
                  taskID: todo.taskID,
                  todoID: todo.id,
                  userLocation: userLocation,
                );
              } catch (e) {
                if (context.mounted) {
                  showErrorAlert(context, e.toString());
                }
              }
            },
          ),
        );
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.ideographic,
        children: [
          const Text('🤖'),
          const SizedBox(width: 2),
          if (locations != null && locations.isNotEmpty) ...[
            const Expanded(child: Text('関連する位置情報・会場・場所をAIに聞き直す')),
          ] else ...[
            const Expanded(child: Text('関連する位置情報・会場・場所をAIに聞く')),
          ],
        ],
      ),
    );
  }
}
