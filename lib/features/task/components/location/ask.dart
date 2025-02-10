import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todomaker/components/error/error_alert.dart';
import 'package:todomaker/components/location/form.dart';
import 'package:todomaker/entity/task.dart';
import 'package:todomaker/provider/task.dart';
import 'package:todomaker/utils/functions/firebase_functions.dart';

class TaskLocationAskAI extends HookConsumerWidget {
  final TaskPrepared task;
  const TaskLocationAskAI({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskFillLocation = ref.watch(taskFillLocationProvider);
    final locations = task.locations;

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
                await taskFillLocation(taskID: task.id, userLocation: userLocation);
                await functions.fillLocation(
                  taskID: task.id,
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
