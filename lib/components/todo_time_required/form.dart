import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todomaker/entity/todo.dart';

class TodoTimeRequiredForm extends HookConsumerWidget {
  final Todo todo;
  final int timeRequired;
  const TodoTimeRequiredForm({super.key, required this.todo, required this.timeRequired});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: timeRequired.toString());
    final text = useState(timeRequired);

    return AlertDialog(
      title: const Text('作業時間を編集'),
      content: Column(
        children: [
          TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: '作業時間',
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (value) {
              text.value = int.parse(value);
            },
            onFieldSubmitted: (value) {
              if (value.isNotEmpty) {
                text.value = int.parse(value);
              }
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('キャンセル'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(text.value);
          },
          child: const Text('保存'),
        ),
      ],
    );
  }
}
