import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todomaker/entity/location_form.dart';
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

class TaskCreate {
  final UserDatabase database;

  TaskCreate({required this.database});

  Future<TaskPreparing> call({required String question}) async {
    final docRef = database.tasksReference().doc();
    final task = TaskPreparing(
      id: docRef.id,
      userID: database.userID,
      question: question,
    );
    await database.taskReference(taskID: task.id).set(task, SetOptions(merge: true));
    return task;
  }
}

@Riverpod(dependencies: [userDatabase])
TaskCreate taskCreate(TaskCreateRef ref) {
  final database = ref.watch(userDatabaseProvider);
  return TaskCreate(database: database);
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
    return database.taskReference(taskID: taskID).update({'completedDateTime': DateTime.now()});
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
    return database.taskReference(taskID: taskID).update({'completedDateTime': null});
  }
}

@Riverpod(dependencies: [userDatabase])
TaskRevertComplete taskRevertComplete(TaskRevertCompleteRef ref) {
  final database = ref.watch(userDatabaseProvider);
  return TaskRevertComplete(database: database);
}

class TaskFillLocation {
  final UserDatabase database;

  TaskFillLocation({required this.database});

  Future<void> call({required String taskID, required LocationFormInfo userLocation}) {
    return database.taskReference(taskID: taskID).update(
      {
        'userLocation': userLocation.toJson(),
        'locations': null,
        'locationsAITextResponse': null,
        'locationsGroundings': null,
      },
    );
  }
}

@Riverpod(dependencies: [userDatabase])
TaskFillLocation taskFillLocation(TaskFillLocationRef ref) {
  final database = ref.watch(userDatabaseProvider);
  return TaskFillLocation(database: database);
}
