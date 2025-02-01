// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'purchase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$customerInfoHash() => r'99bc543824c0b462b41869d350044fd1978bdc6e';

/// See also [customerInfo].
@ProviderFor(customerInfo)
final customerInfoProvider = AutoDisposeStreamProvider<CustomerInfo>.internal(
  customerInfo,
  name: r'customerInfoProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$customerInfoHash,
  dependencies: const <ProviderOrFamily>[],
  allTransitiveDependencies: const <ProviderOrFamily>{},
);

typedef CustomerInfoRef = AutoDisposeStreamProviderRef<CustomerInfo>;
String _$offeringsHash() => r'06a7e9fadc8200b9115c16675938df040bc9dbb2';

/// See also [offerings].
@ProviderFor(offerings)
final offeringsProvider = AutoDisposeFutureProvider<Offerings>.internal(
  offerings,
  name: r'offeringsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$offeringsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OfferingsRef = AutoDisposeFutureProviderRef<Offerings>;
String _$currentOfferingPackagesHash() => r'648dc186cc0f3dd97c71697f0dba73f21834a5f6';

/// See also [currentOfferingPackages].
@ProviderFor(currentOfferingPackages)
final currentOfferingPackagesProvider = AutoDisposeProvider<List<Package>>.internal(
  currentOfferingPackages,
  name: r'currentOfferingPackagesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$currentOfferingPackagesHash,
  dependencies: <ProviderOrFamily>[customerInfoProvider],
  allTransitiveDependencies: <ProviderOrFamily>{customerInfoProvider, ...?customerInfoProvider.allTransitiveDependencies},
);

typedef CurrentOfferingPackagesRef = AutoDisposeProviderRef<List<Package>>;
String _$weeklyPackageHash() => r'd8c57ae30ae72b9f75b0d9818af5433b1d7f4232';

/// See also [weeklyPackage].
@ProviderFor(weeklyPackage)
final weeklyPackageProvider = AutoDisposeProvider<Package?>.internal(
  weeklyPackage,
  name: r'weeklyPackageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$weeklyPackageHash,
  dependencies: <ProviderOrFamily>[currentOfferingPackagesProvider],
  allTransitiveDependencies: <ProviderOrFamily>{currentOfferingPackagesProvider, ...?currentOfferingPackagesProvider.allTransitiveDependencies},
);

typedef WeeklyPackageRef = AutoDisposeProviderRef<Package?>;
String _$monthlyPackageHash() => r'8d088c8a829e6aca119e35699a1be4045a053ba7';

/// See also [monthlyPackage].
@ProviderFor(monthlyPackage)
final monthlyPackageProvider = AutoDisposeProvider<Package?>.internal(
  monthlyPackage,
  name: r'monthlyPackageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$monthlyPackageHash,
  dependencies: <ProviderOrFamily>[currentOfferingPackagesProvider],
  allTransitiveDependencies: <ProviderOrFamily>{currentOfferingPackagesProvider, ...?currentOfferingPackagesProvider.allTransitiveDependencies},
);

typedef MonthlyPackageRef = AutoDisposeProviderRef<Package?>;
String _$sixMonthPackageHash() => r'e417483a34ad2622e2bbedfca167bb7fdf408ecd';

/// See also [sixMonthPackage].
@ProviderFor(sixMonthPackage)
final sixMonthPackageProvider = AutoDisposeProvider<Package?>.internal(
  sixMonthPackage,
  name: r'sixMonthPackageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$sixMonthPackageHash,
  dependencies: <ProviderOrFamily>[currentOfferingPackagesProvider],
  allTransitiveDependencies: <ProviderOrFamily>{currentOfferingPackagesProvider, ...?currentOfferingPackagesProvider.allTransitiveDependencies},
);

typedef SixMonthPackageRef = AutoDisposeProviderRef<Package?>;
String _$annualPackageHash() => r'a0f73f340ef0ae6dc39f6866c85fd2b785ebb251';

/// See also [annualPackage].
@ProviderFor(annualPackage)
final annualPackageProvider = AutoDisposeProvider<Package?>.internal(
  annualPackage,
  name: r'annualPackageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$annualPackageHash,
  dependencies: <ProviderOrFamily>[currentOfferingPackagesProvider],
  allTransitiveDependencies: <ProviderOrFamily>{currentOfferingPackagesProvider, ...?currentOfferingPackagesProvider.allTransitiveDependencies},
);

typedef AnnualPackageRef = AutoDisposeProviderRef<Package?>;
String _$monthlyPremiumPackageHash() => r'0ffcc9f632f99e229be32bf0cf19246f0e04f71c';

/// See also [monthlyPremiumPackage].
@ProviderFor(monthlyPremiumPackage)
final monthlyPremiumPackageProvider = AutoDisposeProvider<Package?>.internal(
  monthlyPremiumPackage,
  name: r'monthlyPremiumPackageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$monthlyPremiumPackageHash,
  dependencies: const <ProviderOrFamily>[],
  allTransitiveDependencies: const <ProviderOrFamily>{},
);

typedef MonthlyPremiumPackageRef = AutoDisposeProviderRef<Package?>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
