import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todomaker/components/loading/indicator.dart';
import 'package:todomaker/components/planning/dialog.dart';
import 'package:todomaker/components/retry/button.dart';
import 'package:todomaker/components/retry/page.dart';
import 'package:todomaker/entity/task.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:todomaker/features/task/page.dart';
import 'package:todomaker/features/todo/page.dart';
import 'package:todomaker/provider/todo.dart';
import 'package:todomaker/style/color.dart';

class TasksTodoList extends HookConsumerWidget {
  final TaskPrepared task;
  // 表示するTodoの数を制限する。オンメモリで制限。クエリでは大した件数ではないので全権取得。コンポーネント分けるほどでもないので引数にする
  final int? limit;
  const TasksTodoList({super.key, required this.task, this.limit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final limit = this.limit;
    final todos = ref.watch(todosProvider(taskID: task.id));

    return Retry(
      retry: () => ref.invalidate(todosProvider(taskID: task.id)),
      child: todos.when(
        data: (todos) {
          // indentが崩れるので分ける
          int sortAlgorithm(Todo a, Todo b) {
            if (a.completedDateTime != null) {
              return 1;
            }
            if (b.completedDateTime != null) {
              return -1;
            }
            return 0;
          }

          final sortedTodos = todos..sort(sortAlgorithm);

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('やること', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  TextButton(
                    onPressed: () async {
                      showDialog(context: context, builder: (context) => AIPlanningDialog(taskID: task.id));
                    },
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.ideographic,
                      children: [
                        Text('🤖'),
                        SizedBox(width: 2),
                        Text('AIで予定を組む'),
                      ],
                    ),
                  ),
                ],
              ),
              for (final todo in sortedTodos.take(limit ?? todos.length)) ...[
                const SizedBox(height: 10),
                TasksTodoRow(
                  key: Key(todo.id),
                  todo: todo,
                ),
              ],
              if (limit != null && todos.length > limit) ...[
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TaskPage(task: task))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text('+ 残り${todos.length - limit}件', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                        const SizedBox(width: 4),
                        const Icon(Icons.arrow_forward_ios, size: 10, color: Colors.grey),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          );
        },
        error: (error, stackTrace) => RetryButton(exception: error, stackTrace: stackTrace),
        loading: () => const Indicator(),
      ),
    );
  }
}

class TasksTodoRow extends HookConsumerWidget {
  final Todo todo;
  const TasksTodoRow({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final supplement = todo.supplement;
    final completed = useState(todo.completedDateTime != null);

    final todoComplete = ref.watch(todoCompleteProvider);
    final todoRevertComplete = ref.watch(todoRevertCompleteProvider);

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => TodoPage(todo: todo)));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 24,
            height: 24,
            child: Checkbox(
              value: completed.value,
              onChanged: (value) {
                if (value == true) {
                  todoComplete(taskID: todo.taskID, todoID: todo.id);
                } else {
                  todoRevertComplete(taskID: todo.taskID, todoID: todo.id);
                }
                completed.value = value ?? false;
              },
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(todo.content, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                if (supplement != null && supplement.isNotEmpty) ...[
                  Text(
                    supplement,
                    style: const TextStyle(fontSize: 14, color: TextColor.darkGray),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          const Icon(Icons.chevron_right, size: 24, color: TextColor.darkGray),
        ],
      ),
    );
  }
}
