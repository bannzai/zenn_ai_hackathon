import 'dart:async';

import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:todomaker/utils/platform/environment.dart';
import 'package:todomaker/secret/secret.dart';
import 'package:todomaker/utils/analytics/analytics.dart';
import 'package:todomaker/utils/analytics/error.dart';
import 'package:todomaker/utils/purchase/error.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'purchase.g.dart';

const promotionProductIdentifierPrefix = 'rc_promo_Premium';
const premiumEntitlementIdentifier = 'Premium';

enum OfferingType { discounted, premium }

extension OfferingTypeFunction on OfferingType {
  String get identifier {
    switch (this) {
      case OfferingType.discounted:
        return 'Discounted';

      case OfferingType.premium:
        return 'Premium';
    }
  }
}

@Riverpod(dependencies: [])
Stream<CustomerInfo> customerInfo(CustomerInfoRef ref) {
  final StreamController<CustomerInfo> stream = StreamController<CustomerInfo>();
  void listener(CustomerInfo customerInfo) {
    stream.sink.add(customerInfo);
  }

  Purchases.addCustomerInfoUpdateListener(listener);

  ref.onDispose(() {
    Purchases.removeCustomerInfoUpdateListener(listener);
    stream.close();
  });
  return stream.stream;
}

extension CustomerInfoExtension on CustomerInfo {
// rc_promo_Premium `のみ` が含まれている場合は値を返す
  DateTime? get promotionExpirationDate {
    final premiumEntitlement = entitlements.active[premiumEntitlementIdentifier];
    final expirationDate = premiumEntitlement?.expirationDate;
    if (premiumEntitlement == null || expirationDate == null) {
      return null;
    }
    if (!premiumEntitlement.productIdentifier.startsWith(promotionProductIdentifierPrefix)) {
      return null;
    }

    if (activeSubscriptions.isEmpty) {
      return null;
    }
    if (activeSubscriptions.any((element) => !element.startsWith(promotionProductIdentifierPrefix))) {
      return null;
    }
    return DateTime.parse(expirationDate);
  }

// プロモーション期間中はfalse
  bool get isPremium {
    if (isInPromotion) {
      return false;
    }
    return entitlements.active.containsKey(premiumEntitlementIdentifier);
  }

  bool get isInPromotion {
    return false;
    // return promotionExpirationDate?.isAfter(DateTime.now()) ?? false;
  }

  DateTime? get discountDeadlineDate {
    return null;
    // return promotionExpirationDate?.add(const Duration(days: 3));
  }

  bool get isInDiscountDuration {
    return false;
    // if (discountDeadlineDate == null) {
    //   return false;
    // }
    // return discountDeadlineDate!.isAfter(DateTime.now());
  }

  OfferingType get currentOfferingType {
    if (isInDiscountDuration) {
      return OfferingType.discounted;
    } else {
      return OfferingType.premium;
    }
  }
}

@Riverpod()
Future<Offerings> offerings(OfferingsRef ref) {
  return Purchases.getOfferings();
}

@Riverpod(dependencies: [customerInfo])
List<Package> currentOfferingPackages(CurrentOfferingPackagesRef ref) {
  final offerings = ref.watch(offeringsProvider).asData?.value;
  final customerInfo = ref.watch(customerInfoProvider).asData?.value;
  if (offerings == null || customerInfo == null) {
    return [];
  }

  final offering = offerings.all[customerInfo.currentOfferingType.identifier];
  if (offering != null) {
    return offering.availablePackages;
  }
  return [];
}

@Riverpod(dependencies: [currentOfferingPackages])
Package? weeklyPackage(WeeklyPackageRef ref) {
  final currentOfferingPackages = ref.watch(currentOfferingPackagesProvider);
  return currentOfferingPackages.firstWhereOrNull((element) => element.packageType == PackageType.weekly);
}

@Riverpod(dependencies: [currentOfferingPackages])
Package? monthlyPackage(MonthlyPackageRef ref) {
  final currentOfferingPackages = ref.watch(currentOfferingPackagesProvider);
  return currentOfferingPackages.firstWhereOrNull((element) => element.packageType == PackageType.monthly);
}

@Riverpod(dependencies: [currentOfferingPackages])
Package? sixMonthPackage(SixMonthPackageRef ref) {
  final currentOfferingPackages = ref.watch(currentOfferingPackagesProvider);
  return currentOfferingPackages.firstWhereOrNull((element) => element.packageType == PackageType.sixMonth);
}

@Riverpod(dependencies: [currentOfferingPackages])
Package? annualPackage(SixMonthPackageRef ref) {
  final currentOfferingPackages = ref.watch(currentOfferingPackagesProvider);
  return currentOfferingPackages.firstWhereOrNull((element) => element.packageType == PackageType.annual);
}

@Riverpod(dependencies: [])
Package? monthlyPremiumPackage(MonthlyPremiumPackageRef ref) {
  const premiumPackageOfferingType = OfferingType.premium;
  final offering = ref.watch(offeringsProvider).valueOrNull?.all[premiumPackageOfferingType.identifier];
  if (offering == null) {
    return null;
  }
  return offering.availablePackages.firstWhereOrNull((element) => element.packageType == PackageType.monthly);
}

Future<void> initializePurchase(String uid) async {
  await Purchases.setLogLevel(Environment.isDevelopment ? LogLevel.debug : LogLevel.info);
  Purchases.configure(PurchasesConfiguration(Secret.revenueCatPublicAPIKey)..appUserID = uid);
  Purchases.logIn(uid);
}

final purchaseProvider = Provider((ref) => Purchase());

class Purchase {
  /// Return true indicates end of regularllly pattern.
  /// Return false indicates not regulally pattern.
  /// Return value is used to display the completion page
  Future<bool> call(Package package) async {
    try {
      final purchaserInfo = await Purchases.purchasePackage(package);
      final premiumEntitlement = purchaserInfo.entitlements.all[premiumEntitlementIdentifier];
      if (premiumEntitlement == null) {
        throw AssertionError('unexpected premium entitlements is not exists');
      }
      if (!premiumEntitlement.isActive) {
        throw const FormatException('購入が完了していません。再度お試しください');
      }
      return Future.value(true);
    } on PlatformException catch (exception, stack) {
      analytics.logEvent(
          name: 'catched_purchase_exception',
          parameters: {'code': exception.code, 'details': exception.details.toString(), 'message': exception.message ?? ''});
      final newException = mapToDisplayedException(exception);
      if (newException == null) {
        return Future.value(false);
      }
      errorLogger.recordError(exception, stack);
      throw newException;
    } catch (exception, stack) {
      analytics.logEvent(name: 'catched_purchase_anonymous', parameters: {
        'exception_type': exception.runtimeType.toString(),
      });
      errorLogger.recordError(exception, stack);
      rethrow;
    }
  }
}
