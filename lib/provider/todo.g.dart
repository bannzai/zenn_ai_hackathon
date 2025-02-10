// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$todosHash() => r'b3ff05b41676693a2841b3ca34ef7ab6839741e5';

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

/// See also [todos].
@ProviderFor(todos)
const todosProvider = TodosFamily();

/// See also [todos].
class TodosFamily extends Family<AsyncValue<List<Todo>>> {
  /// See also [todos].
  const TodosFamily();

  /// See also [todos].
  TodosProvider call({
    required String taskID,
  }) {
    return TodosProvider(
      taskID: taskID,
    );
  }

  @override
  TodosProvider getProviderOverride(
    covariant TodosProvider provider,
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
  String? get name => r'todosProvider';
}

/// See also [todos].
class TodosProvider extends AutoDisposeStreamProvider<List<Todo>> {
  /// See also [todos].
  TodosProvider({
    required String taskID,
  }) : this._internal(
          (ref) => todos(
            ref as TodosRef,
            taskID: taskID,
          ),
          from: todosProvider,
          name: r'todosProvider',
          debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$todosHash,
          dependencies: TodosFamily._dependencies,
          allTransitiveDependencies: TodosFamily._allTransitiveDependencies,
          taskID: taskID,
        );

  TodosProvider._internal(
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
    Stream<List<Todo>> Function(TodosRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TodosProvider._internal(
        (ref) => create(ref as TodosRef),
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
  AutoDisposeStreamProviderElement<List<Todo>> createElement() {
    return _TodosProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TodosProvider && other.taskID == taskID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TodosRef on AutoDisposeStreamProviderRef<List<Todo>> {
  /// The parameter `taskID` of this provider.
  String get taskID;
}

class _TodosProviderElement extends AutoDisposeStreamProviderElement<List<Todo>> with TodosRef {
  _TodosProviderElement(super.provider);

  @override
  String get taskID => (origin as TodosProvider).taskID;
}

String _$todoHash() => r'375dc9039afe58bb931db62594702bb02e123aad';

/// See also [todo].
@ProviderFor(todo)
const todoProvider = TodoFamily();

/// See also [todo].
class TodoFamily extends Family<AsyncValue<Todo>> {
  /// See also [todo].
  const TodoFamily();

  /// See also [todo].
  TodoProvider call({
    required String taskID,
    required String todoID,
  }) {
    return TodoProvider(
      taskID: taskID,
      todoID: todoID,
    );
  }

  @override
  TodoProvider getProviderOverride(
    covariant TodoProvider provider,
  ) {
    return call(
      taskID: provider.taskID,
      todoID: provider.todoID,
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
  String? get name => r'todoProvider';
}

/// See also [todo].
class TodoProvider extends AutoDisposeStreamProvider<Todo> {
  /// See also [todo].
  TodoProvider({
    required String taskID,
    required String todoID,
  }) : this._internal(
          (ref) => todo(
            ref as TodoRef,
            taskID: taskID,
            todoID: todoID,
          ),
          from: todoProvider,
          name: r'todoProvider',
          debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$todoHash,
          dependencies: TodoFamily._dependencies,
          allTransitiveDependencies: TodoFamily._allTransitiveDependencies,
          taskID: taskID,
          todoID: todoID,
        );

  TodoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.taskID,
    required this.todoID,
  }) : super.internal();

  final String taskID;
  final String todoID;

  @override
  Override overrideWith(
    Stream<Todo> Function(TodoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TodoProvider._internal(
        (ref) => create(ref as TodoRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        taskID: taskID,
        todoID: todoID,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Todo> createElement() {
    return _TodoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TodoProvider && other.taskID == taskID && other.todoID == todoID;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskID.hashCode);
    hash = _SystemHash.combine(hash, todoID.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TodoRef on AutoDisposeStreamProviderRef<Todo> {
  /// The parameter `taskID` of this provider.
  String get taskID;

  /// The parameter `todoID` of this provider.
  String get todoID;
}

class _TodoProviderElement extends AutoDisposeStreamProviderElement<Todo> with TodoRef {
  _TodoProviderElement(super.provider);

  @override
  String get taskID => (origin as TodoProvider).taskID;
  @override
  String get todoID => (origin as TodoProvider).todoID;
}

String _$todoDeleteHash() => r'20b8688330f0debb39c51f7487fdc36a63579ac2';

/// See also [todoDelete].
@ProviderFor(todoDelete)
final todoDeleteProvider = AutoDisposeProvider<TodoDelete>.internal(
  todoDelete,
  name: r'todoDeleteProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$todoDeleteHash,
  dependencies: <ProviderOrFamily>[userDatabaseProvider],
  allTransitiveDependencies: <ProviderOrFamily>{userDatabaseProvider, ...?userDatabaseProvider.allTransitiveDependencies},
);

typedef TodoDeleteRef = AutoDisposeProviderRef<TodoDelete>;
String _$todoCompleteHash() => r'9579a92961a637d2c5fb8ad8c82090c5d2521096';

/// See also [todoComplete].
@ProviderFor(todoComplete)
final todoCompleteProvider = AutoDisposeProvider<TodoComplete>.internal(
  todoComplete,
  name: r'todoCompleteProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$todoCompleteHash,
  dependencies: <ProviderOrFamily>[userDatabaseProvider],
  allTransitiveDependencies: <ProviderOrFamily>{userDatabaseProvider, ...?userDatabaseProvider.allTransitiveDependencies},
);

typedef TodoCompleteRef = AutoDisposeProviderRef<TodoComplete>;
String _$todoRevertCompleteHash() => r'c580dfd98b8d232fd722b1737e8921c7f95db4c0';

/// See also [todoRevertComplete].
@ProviderFor(todoRevertComplete)
final todoRevertCompleteProvider = AutoDisposeProvider<TodoRevertComplete>.internal(
  todoRevertComplete,
  name: r'todoRevertCompleteProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$todoRevertCompleteHash,
  dependencies: <ProviderOrFamily>[userDatabaseProvider],
  allTransitiveDependencies: <ProviderOrFamily>{userDatabaseProvider, ...?userDatabaseProvider.allTransitiveDependencies},
);

typedef TodoRevertCompleteRef = AutoDisposeProviderRef<TodoRevertComplete>;
String _$todoFillLocationHash() => r'81c71c58a47f07c9196a27830f147690eaf52874';

/// See also [todoFillLocation].
@ProviderFor(todoFillLocation)
final todoFillLocationProvider = AutoDisposeProvider<TodoFillLocation>.internal(
  todoFillLocation,
  name: r'todoFillLocationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$todoFillLocationHash,
  dependencies: <ProviderOrFamily>[userDatabaseProvider],
  allTransitiveDependencies: <ProviderOrFamily>{userDatabaseProvider, ...?userDatabaseProvider.allTransitiveDependencies},
);

typedef TodoFillLocationRef = AutoDisposeProviderRef<TodoFillLocation>;
String _$todoEditTimeRequiredHash() => r'c63aac3706d1b190e6ec6bd4f09eb0ee6eab00f2';

/// See also [todoEditTimeRequired].
@ProviderFor(todoEditTimeRequired)
final todoEditTimeRequiredProvider = AutoDisposeProvider<TodoEditTimeRequired>.internal(
  todoEditTimeRequired,
  name: r'todoEditTimeRequiredProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$todoEditTimeRequiredHash,
  dependencies: <ProviderOrFamily>[userDatabaseProvider],
  allTransitiveDependencies: <ProviderOrFamily>{userDatabaseProvider, ...?userDatabaseProvider.allTransitiveDependencies},
);

typedef TodoEditTimeRequiredRef = AutoDisposeProviderRef<TodoEditTimeRequired>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
