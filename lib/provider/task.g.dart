// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tasksHash() => r'5dc788e7440da2e0178adbedd34c5290531422a6';

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
String _$taskHash() => r'839609bce83ce7ea21ebe37ceb23335c950c7aad';

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
class TaskProvider extends AutoDisposeStreamProvider<Task> {
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
    Stream<Task> Function(TaskRef provider) create,
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
  AutoDisposeStreamProviderElement<Task> createElement() {
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

mixin TaskRef on AutoDisposeStreamProviderRef<Task> {
  /// The parameter `taskID` of this provider.
  String get taskID;
}

class _TaskProviderElement extends AutoDisposeStreamProviderElement<Task> with TaskRef {
  _TaskProviderElement(super.provider);

  @override
  String get taskID => (origin as TaskProvider).taskID;
}

String _$taskCreateHash() => r'551d1e5189d300c11bffd63d8d36600ad7abb22e';

/// See also [taskCreate].
@ProviderFor(taskCreate)
final taskCreateProvider = AutoDisposeProvider<TaskCreate>.internal(
  taskCreate,
  name: r'taskCreateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$taskCreateHash,
  dependencies: <ProviderOrFamily>[userDatabaseProvider],
  allTransitiveDependencies: <ProviderOrFamily>{userDatabaseProvider, ...?userDatabaseProvider.allTransitiveDependencies},
);

typedef TaskCreateRef = AutoDisposeProviderRef<TaskCreate>;
String _$taskDeleteHash() => r'8ebe4593ee12f1d11c88a85b5619c66d62d7a5cb';

/// See also [taskDelete].
@ProviderFor(taskDelete)
final taskDeleteProvider = AutoDisposeProvider<TaskDelete>.internal(
  taskDelete,
  name: r'taskDeleteProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$taskDeleteHash,
  dependencies: <ProviderOrFamily>[userDatabaseProvider],
  allTransitiveDependencies: <ProviderOrFamily>{userDatabaseProvider, ...?userDatabaseProvider.allTransitiveDependencies},
);

typedef TaskDeleteRef = AutoDisposeProviderRef<TaskDelete>;
String _$taskCompleteHash() => r'f6a7a25cee5742e4a0bae345e086b6cac7d12eda';

/// See also [taskComplete].
@ProviderFor(taskComplete)
final taskCompleteProvider = AutoDisposeProvider<TaskComplete>.internal(
  taskComplete,
  name: r'taskCompleteProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$taskCompleteHash,
  dependencies: <ProviderOrFamily>[userDatabaseProvider],
  allTransitiveDependencies: <ProviderOrFamily>{userDatabaseProvider, ...?userDatabaseProvider.allTransitiveDependencies},
);

typedef TaskCompleteRef = AutoDisposeProviderRef<TaskComplete>;
String _$taskRevertCompleteHash() => r'fc6c12ff14b0fe379e8629e5170d6fd489fed69d';

/// See also [taskRevertComplete].
@ProviderFor(taskRevertComplete)
final taskRevertCompleteProvider = AutoDisposeProvider<TaskRevertComplete>.internal(
  taskRevertComplete,
  name: r'taskRevertCompleteProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$taskRevertCompleteHash,
  dependencies: <ProviderOrFamily>[userDatabaseProvider],
  allTransitiveDependencies: <ProviderOrFamily>{userDatabaseProvider, ...?userDatabaseProvider.allTransitiveDependencies},
);

typedef TaskRevertCompleteRef = AutoDisposeProviderRef<TaskRevertComplete>;
String _$taskFillLocationHash() => r'deccea29213fb3a7265a73ccb60f7625c84c95f3';

/// See also [taskFillLocation].
@ProviderFor(taskFillLocation)
final taskFillLocationProvider = AutoDisposeProvider<TaskFillLocation>.internal(
  taskFillLocation,
  name: r'taskFillLocationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$taskFillLocationHash,
  dependencies: <ProviderOrFamily>[userDatabaseProvider],
  allTransitiveDependencies: <ProviderOrFamily>{userDatabaseProvider, ...?userDatabaseProvider.allTransitiveDependencies},
);

typedef TaskFillLocationRef = AutoDisposeProviderRef<TaskFillLocation>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
