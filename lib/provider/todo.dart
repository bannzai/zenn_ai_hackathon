import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todomaker/entity/location_form.dart';
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

@Riverpod(dependencies: [userDatabase])
Stream<Todo> todo(TodoRef ref, {required String taskID, required String todoID}) {
  final database = ref.watch(userDatabaseProvider);
  return database.todoReference(taskID: taskID, todoID: todoID).snapshots().map((event) => event.data()!);
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

class TodoFillLocation {
  final UserDatabase database;

  TodoFillLocation({required this.database});

  Future<void> call({
    required String taskID,
    required String todoID,
    required LocationFormInfo userLocation,
  }) {
    return database.todoReference(taskID: taskID, todoID: todoID).update(
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
TodoFillLocation todoFillLocation(TodoFillLocationRef ref) {
  final database = ref.watch(userDatabaseProvider);
  return TodoFillLocation(database: database);
}

class TodoEditTimeRequired {
  final UserDatabase database;

  TodoEditTimeRequired({required this.database});

  Future<void> call({
    required String taskID,
    required String todoID,
    required int timeRequired,
  }) {
    return database.todoReference(taskID: taskID, todoID: todoID).update({'userTimeRequired': timeRequired});
  }
}

@Riverpod(dependencies: [userDatabase])
TodoEditTimeRequired todoEditTimeRequired(TodoEditTimeRequiredRef ref) {
  final database = ref.watch(userDatabaseProvider);
  return TodoEditTimeRequired(database: database);
}

class TodoSetCalendarSchedule {
  final UserDatabase database;

  TodoSetCalendarSchedule({required this.database});

  Future<void> call({
    required String taskID,
    required String todoID,
    required TodoCalendarSchedule? todoCalendarSchedule,
  }) {
    return database.todoReference(taskID: taskID, todoID: todoID).update({'calendarSchedule': todoCalendarSchedule?.toJson()});
  }
}

@Riverpod(dependencies: [userDatabase])
TodoSetCalendarSchedule todoSetCalendarSchedule(TodoSetCalendarScheduleRef ref) {
  final database = ref.watch(userDatabaseProvider);
  return TodoSetCalendarSchedule(database: database);
}
