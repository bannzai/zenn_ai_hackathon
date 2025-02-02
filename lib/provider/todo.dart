import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:todomaker/features/root/resolver/database.dart';

part 'todo.g.dart';

@Riverpod(dependencies: [userDatabase])
Stream<List<Todo>> todos(TodosRef ref, {required String taskID}) {
  final database = ref.watch(userDatabaseProvider);
  return database.todosReference(taskID: taskID).snapshots().map((event) => event.docs.map((doc) => doc.data()).toList());
}
