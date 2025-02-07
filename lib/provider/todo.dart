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

class TodoComplete {
  final UserDatabase database;

  TodoComplete({required this.database});

  Future<void> call({required String taskID, required String todoID}) {
    return database.todosReference(taskID: taskID).doc(todoID).update({'completedDateTime': DateTime.now()});
  }
}

@Riverpod(dependencies: [userDatabase])
TodoComplete todoComplete(TodoCompleteRef ref) {
  final database = ref.watch(userDatabaseProvider);
  return TodoComplete(database: database);
}

class TodoRevertComplete {
  final UserDatabase database;

  TodoRevertComplete({required this.database});

  Future<void> call({required String taskID, required String todoID}) {
    return database.todosReference(taskID: taskID).doc(todoID).update({'completedDateTime': null});
  }
}

@Riverpod(dependencies: [userDatabase])
TodoRevertComplete todoRevertComplete(TodoRevertCompleteRef ref) {
  final database = ref.watch(userDatabaseProvider);
  return TodoRevertComplete(database: database);
}
