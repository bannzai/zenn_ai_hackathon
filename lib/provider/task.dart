import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todomaker/entity/task.dart';
import 'package:todomaker/features/root/resolver/database.dart';

part 'task.g.dart';

@Riverpod(dependencies: [userDatabase])
Stream<List<Task>> tasks(TasksRef ref) {
  final database = ref.watch(userDatabaseProvider);
  return database
      .tasksReference()
      .orderBy('serverCreatedDateTime', descending: true)
      .snapshots()
      .map((event) => event.docs.map((doc) => doc.data()).toList());
}

@Riverpod(dependencies: [userDatabase])
Future<Task> task(TaskRef ref, {required String taskID}) async {
  final database = ref.watch(userDatabaseProvider);
  final task = await database.taskReference(taskID: taskID).get();
  return task.data()!;
}

class TaskDelete {
  final UserDatabase database;

  TaskDelete({required this.database});

  Future<void> call({required String taskID}) {
    return database.taskReference(taskID: taskID).delete();
  }
}

@Riverpod(dependencies: [userDatabase])
TaskDelete taskDelete(TaskDeleteRef ref) {
  final database = ref.watch(userDatabaseProvider);
  return TaskDelete(database: database);
}

class TaskComplete {
  final UserDatabase database;

  TaskComplete({required this.database});

  Future<void> call({required String taskID}) {
    return database.taskReference(taskID: taskID).update({'completed': true});
  }
}

@Riverpod(dependencies: [userDatabase])
TaskComplete taskComplete(TaskCompleteRef ref) {
  final database = ref.watch(userDatabaseProvider);
  return TaskComplete(database: database);
}

class TaskRevertComplete {
  final UserDatabase database;

  TaskRevertComplete({required this.database});

  Future<void> call({required String taskID}) {
    return database.taskReference(taskID: taskID).update({'completed': false});
  }
}

@Riverpod(dependencies: [userDatabase])
TaskRevertComplete taskRevertComplete(TaskRevertCompleteRef ref) {
  final database = ref.watch(userDatabaseProvider);
  return TaskRevertComplete(database: database);
}
