// ignore_for_file: prefer_function_declarations_over_variables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todomaker/components/loading/indicator.dart';
import 'package:todomaker/entity/app_user.dart';
import 'package:todomaker/entity/task.dart';
import 'package:todomaker/entity/todo.dart';
import 'package:todomaker/features/root/resolver/auth.dart';

part 'database.g.dart';

abstract class _CollectionPath {
  static const String users = '/users';
  static String userPrivates({required String userID}) => '$users/$userID/privates';
  static String tasks({required String userID}) => '$users/$userID/tasks';
  static String todos({required String userID, required String taskID}) => '$users/$userID/tasks/$taskID/todos';
}

@Riverpod(keepAlive: true, dependencies: [firebaseUserChanges])
UserDatabase userDatabase(UserDatabaseRef ref) {
  final stream = ref.watch(firebaseUserChangesProvider);
  final uid = stream.asData?.value?.uid ?? FirebaseAuth.instance.currentUser?.uid;
  if (uid == null) {
    throw Exception('User ID is not found');
  }
  return UserDatabase(userID: uid);
}

class UserDatabase {
  final String userID;
  UserDatabase({required this.userID});

  final FromFirestore<AppUser> _userFromFirestore = (snapshot, options) => AppUser.fromJson(snapshot.data()!..['id'] = snapshot.id);
  final ToFirestore<AppUser> _userToFirestore = (user, options) => user.toJson();
  DocumentReference<AppUser> userReference() => FirebaseFirestore.instance.collection(_CollectionPath.users).doc(userID).withConverter(
        fromFirestore: _userFromFirestore,
        toFirestore: _userToFirestore,
      );
  DocumentReference userPrivateRawReference() => FirebaseFirestore.instance.collection(_CollectionPath.userPrivates(userID: userID)).doc(userID);

  final FromFirestore<Task> _taskFromFirestore = (snapshot, options) => Task.fromJson(snapshot.data()!..['id'] = snapshot.id);
  final ToFirestore<Task> _taskToFirestore = (task, options) => task.toJson();
  CollectionReference<Task> tasksReference() => FirebaseFirestore.instance.collection(_CollectionPath.tasks(userID: userID)).withConverter(
        fromFirestore: _taskFromFirestore,
        toFirestore: _taskToFirestore,
      );

  final FromFirestore<Todo> _todoFromFirestore = (snapshot, options) => Todo.fromJson(snapshot.data()!..['id'] = snapshot.id);
  final ToFirestore<Todo> _todoToFirestore = (todo, options) => todo.toJson();
  CollectionReference<Todo> todosReference({required String taskID}) =>
      FirebaseFirestore.instance.collection(_CollectionPath.todos(userID: userID, taskID: taskID)).withConverter(
            fromFirestore: _todoFromFirestore,
            toFirestore: _todoToFirestore,
          );
}

class UserDatabaseResolver extends HookConsumerWidget {
  final Widget Function(BuildContext) builder;

  const UserDatabaseResolver({super.key, required this.builder});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(firebaseUserChangesProvider).asData?.value;

    useEffect(() {
      if (user == null) {
        ref.invalidate(userDatabaseProvider);
      }
      return null;
    }, [user]);

    if (user != null) {
      return ProviderScope(
        overrides: [userDatabaseProvider.overrideWith((ref) => UserDatabase(userID: user.uid))],
        child: Consumer(
          builder: ((context, ref, child) => builder(context)),
        ),
      );
    } else {
      return const IndicatorPage();
    }
  }
}
