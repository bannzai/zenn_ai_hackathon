// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$appUserIDHash() => r'4f06a266d5801bd41331f035ac4916bc2380ea3f';

/// See also [appUserID].
@ProviderFor(appUserID)
final appUserIDProvider = AutoDisposeProvider<String>.internal(
  appUserID,
  name: r'appUserIDProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$appUserIDHash,
  dependencies: <ProviderOrFamily>[appUserProvider],
  allTransitiveDependencies: <ProviderOrFamily>{appUserProvider, ...?appUserProvider.allTransitiveDependencies},
);

typedef AppUserIDRef = AutoDisposeProviderRef<String>;
String _$appUserHash() => r'd4db768e8c250fd8a19d1bb85ead8d5df365a312';

/// See also [appUser].
@ProviderFor(appUser)
final appUserProvider = AutoDisposeStreamProvider<AppUser>.internal(
  appUser,
  name: r'appUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$appUserHash,
  dependencies: <ProviderOrFamily>[userDatabaseProvider],
  allTransitiveDependencies: <ProviderOrFamily>{userDatabaseProvider, ...?userDatabaseProvider.allTransitiveDependencies},
);

typedef AppUserRef = AutoDisposeStreamProviderRef<AppUser>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
