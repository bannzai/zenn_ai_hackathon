import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todomaker/components/loading/indicator.dart';
import 'package:todomaker/components/retry/page.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:todomaker/provider/todo.dart';

class TasksTodoList extends HookConsumerWidget {
  final String taskID;
  // 表示するTodoの数を制限する。オンメモリで制限。クエリでは大した件数ではないので全権取得。コンポーネント分けるほどでもないので引数にする
  final int? limit;
  const TasksTodoList({super.key, required this.taskID, this.limit});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final limit = this.limit;
    final todos = ref.watch(todosProvider(taskID: taskID));

    return Retry(
      retry: () => ref.invalidate(todosProvider(taskID: taskID)),
      child: todos.when(
        data: (todos) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final todo in todos.take(limit ?? todos.length)) ...[
              TasksPageTodoRow(todo: todo),
              const SizedBox(height: 10),
            ],
            if (limit != null && todos.length > limit) ...[
              Align(
                alignment: Alignment.bottomRight,
                child: Text('+ 残り${todos.length - limit}件', style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ),
            ],
          ],
        ),
        error: (error, stackTrace) => RetryPage(exception: error, stackTrace: stackTrace),
        loading: () => const IndicatorPage(),
      ),
    );
  }
}

class TasksPageTodoRow extends HookConsumerWidget {
  final Todo todo;
  const TasksPageTodoRow({super.key, required this.todo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completed = useState(todo.completed);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: completed.value,
            onChanged: (value) {
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
              Text(todo.supplement, style: const TextStyle(fontSize: 14), maxLines: 2),
            ],
          ),
        ),
      ],
    );
  }
}
