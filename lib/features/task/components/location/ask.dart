import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
    return TextButton(
      onPressed: () async {
        showDialog(
          context: context,
          builder: (context) => LocationForm(
            onSubmit: (userLocation) async {
              await taskFillLocation(taskID: task.id, userLocation: userLocation);
              await functions.fillLocation(
                taskID: task.id,
                userLocation: userLocation,
              );
            },
          ),
        );
      },
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.ideographic,
        children: [
          Text('🤖'),
          SizedBox(width: 2),
          Text('関連する位置情報・会場・場所をAIに聞く'),
        ],
      ),
    );
  }
}
