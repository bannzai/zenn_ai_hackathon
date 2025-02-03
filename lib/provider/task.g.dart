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
String _$taskHash() => r'22dd5a62737bced6e9aaaa7b5d6f07d4b3591424';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [task].
@ProviderFor(task)
const taskProvider = TaskFamily();

/// See also [task].
class TaskFamily extends Family<AsyncValue<Task>> {
  /// See also [task].
  const TaskFamily();

  /// See also [task].
  TaskProvider call({
    required String taskID,
  }) {
    return TaskProvider(
      taskID: taskID,
    );
  }

  @override
  TaskProvider getProviderOverride(
    covariant TaskProvider provider,
  ) {
    return call(
      taskID: provider.taskID,
    );
  }

  static final Iterable<ProviderOrFamily> _dependencies = <ProviderOrFamily>[userDatabaseProvider];

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static final Iterable<ProviderOrFamily> _allTransitiveDependencies = <ProviderOrFamily>{
    userDatabaseProvider,
    ...?userDatabaseProvider.allTransitiveDependencies
  };

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies => _allTransitiveDependencies;

  @override
  String? get name => r'taskProvider';
}

/// See also [task].
class TaskProvider extends AutoDisposeFutureProvider<Task> {
  /// See also [task].
  TaskProvider({
    required String taskID,
  }) : this._internal(
          (ref) => task(
            ref as TaskRef,
            taskID: taskID,
          ),
          from: taskProvider,
          name: r'taskProvider',
          debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$taskHash,
          dependencies: TaskFamily._dependencies,
          allTransitiveDependencies: TaskFamily._allTransitiveDependencies,
          taskID: taskID,
        );

  TaskProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.taskID,
  }) : super.internal();

  final String taskID;

  @override
  Override overrideWith(
    FutureOr<Task> Function(TaskRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TaskProvider._internal(
        (ref) => create(ref as TaskRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        taskID: taskID,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Task> createElement() {
    return _TaskProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskProvider && other.taskID == taskID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TaskRef on AutoDisposeFutureProviderRef<Task> {
  /// The parameter `taskID` of this provider.
  String get taskID;
}

class _TaskProviderElement extends AutoDisposeFutureProviderElement<Task> with TaskRef {
  _TaskProviderElement(super.provider);

  @override
  String get taskID => (origin as TaskProvider).taskID;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
