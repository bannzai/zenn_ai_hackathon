// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tasksHash() => r'5c3af456be9db407af3dbbe76855fd9332b80867';

/// See also [tasks].
@ProviderFor(tasks)
final tasksProvider = AutoDisposeStreamProvider<List<Task>>.internal(
  tasks,
  name: r'tasksProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$tasksHash,
  dependencies: <ProviderOrFamily>[userDatabaseProvider],
  allTransitiveDependencies: <ProviderOrFamily>{userDatabaseProvider, ...?userDatabaseProvider.allTransitiveDependencies},
);

typedef TasksRef = AutoDisposeStreamProviderRef<List<Task>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
