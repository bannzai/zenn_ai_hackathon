// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userDatabaseHash() => r'f303f1ceb234a43ec9b0dcdeace28917c9f85c14';

/// See also [userDatabase].
@ProviderFor(userDatabase)
final userDatabaseProvider = Provider<UserDatabase>.internal(
  userDatabase,
  name: r'userDatabaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$userDatabaseHash,
  dependencies: <ProviderOrFamily>[firebaseUserChangesProvider],
  allTransitiveDependencies: <ProviderOrFamily>{firebaseUserChangesProvider, ...?firebaseUserChangesProvider.allTransitiveDependencies},
);

typedef UserDatabaseRef = ProviderRef<UserDatabase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
