import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:todomaker/features/root/resolver/database.dart';

part 'todo.g.dart';

@Riverpod(dependencies: [userDatabase])
Stream<List<Todo>> todos(TodosRef ref, {required String taskID}) {
  final database = ref.watch(userDatabaseProvider);
  return database
      .todosReference(taskID: taskID)
      .orderBy('serverCreatedDateTime', descending: false)
      .snapshots()
      .map((event) => event.docs.map((doc) => doc.data()).toList());
}

class TodoDelete {
  final UserDatabase database;

  TodoDelete({required this.database});

  Future<void> call({required String taskID, required String todoID}) {
    return database.todosReference(taskID: taskID).doc(todoID).delete();
  }
}

@Riverpod(dependencies: [userDatabase])
TodoDelete todoDelete(TodoDeleteRef ref) {
  final database = ref.watch(userDatabaseProvider);
  return TodoDelete(database: database);
}
