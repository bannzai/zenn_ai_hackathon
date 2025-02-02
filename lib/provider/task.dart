import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todomaker/entity/task.dart';
import 'package:todomaker/features/root/resolver/database.dart';

part 'task.g.dart';

@Riverpod(dependencies: [userDatabase])
Stream<List<Task>> tasks(TasksRef ref) {
  final database = ref.watch(userDatabaseProvider);
  return database.tasksReference().snapshots().map((event) => event.docs.map((doc) => doc.data()).toList());
}
