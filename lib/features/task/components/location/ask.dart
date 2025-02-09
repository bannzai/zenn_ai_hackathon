import 'package:flutter/material.dart';
import 'package:todomaker/components/location/form.dart';
import 'package:todomaker/entity/task.dart';
import 'package:todomaker/utils/functions/firebase_functions.dart';

class TaskLocationAskAI extends StatelessWidget {
  final TaskPrepared task;
  const TaskLocationAskAI({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        showDialog(
          context: context,
          builder: (context) => LocationForm(
            onSubmit: (location) async {
              await functions.fillLocation(
                taskID: task.id,
                userLocation: location,
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
