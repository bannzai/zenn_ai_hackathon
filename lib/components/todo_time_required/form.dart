import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:todomaker/utils/format/time_of_day.dart';
import 'package:todomaker/utils/picker/time.dart';

class TodoTimeRequiredForm extends HookConsumerWidget {
  final Todo todo;
  final AppTimeOfDay timeRequired;
  const TodoTimeRequiredForm({super.key, required this.todo, required this.timeRequired});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController(text: TimeOfDayFormatter.format(this.timeRequired));
    final timeRequired = useState(this.timeRequired);

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
              timeRequired.value = AppTimeOfDay.fromSeconds(int.parse(value));
            },
            onFieldSubmitted: (value) {
              if (value.isNotEmpty) {
                timeRequired.value = AppTimeOfDay.fromSeconds(int.parse(value));
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
            Navigator.of(context).pop(timeRequired.value);
          },
          child: const Text('保存'),
        ),
      ],
    );
  }
}
