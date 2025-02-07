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

class TodoCheck {
  final UserDatabase database;

  TodoCheck({required this.database});

  Future<void> call({required String taskID, required String todoID}) {
    return database.todosReference(taskID: taskID).doc(todoID).update({'completedDateTime': DateTime.now()});
  }
}

@Riverpod(dependencies: [userDatabase])
TodoCheck todoCheck(TodoCheckRef ref) {
  final database = ref.watch(userDatabaseProvider);
  return TodoCheck(database: database);
}

class TodoUncheck {
  final UserDatabase database;

  TodoUncheck({required this.database});

  Future<void> call({required String taskID, required String todoID}) {
    return database.todosReference(taskID: taskID).doc(todoID).update({'completedDateTime': null});
  }
}

@Riverpod(dependencies: [userDatabase])
TodoUncheck todoUncheck(TodoUncheckRef ref) {
  final database = ref.watch(userDatabaseProvider);
  return TodoUncheck(database: database);
}
