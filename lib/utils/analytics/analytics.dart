import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/foundation.dart';

final firebaseAnalytics = FirebaseAnalytics.instance;

var analyticsDebugIsEnabled = false;

class Analytics {
  void debug({required String name, Map<String, Object>? parameters}) async {
    if (analyticsDebugIsEnabled || kDebugMode) {
      logEvent(name: name, parameters: parameters);
    }
  }

  void logEvent({required String name, Map<String, Object>? parameters}) async {
    assert(name.length <= 40, 'firebase analytics log event name limit length up to 40');
    if (kDebugMode) {
      print('[INFO] logEvent name: $name, parameters: $parameters');
    }

    if (parameters != null) {
      for (final key in parameters.keys) {
        final param = parameters[key];
        if (param is DateTime) {
          parameters[key] = param.toIso8601String();
        }
        if (param is bool) {
          parameters[key] = param ? 'true' : 'false';
        }
      }
    }
    try {
      await firebaseAnalytics.logEvent(name: name, parameters: parameters);
    } catch (e) {
      debugPrint('analytics error: $e');
    }
  }

  void setCurrentScreen({required String screenName, String screenClassOverride = 'Flutter'}) async {
    unawaited(firebaseAnalytics.logEvent(name: 'screen_$screenName'));
    return firebaseAnalytics.logScreenView(screenName: screenName);
  }

  /// Up to 25 user property names are supported.
  // The "firebase_" prefix is reserved and should not be used for
  /// user property names.
  void setUserProperties(String name, value) {
    assert(name.toLowerCase() != 'age');
    assert(name.toLowerCase() != 'gender');
    assert(name.toLowerCase() != 'interest');
    assert(name.length < 25, 'firebase setUserProperties name limit length up to 25');
    assert(!name.startsWith('firebase_'));

    if (kDebugMode) {
      print('[INFO] setUserProperties name: $name, value: $value');
    }
    firebaseAnalytics.setUserProperty(name: name, value: value);
  }
}

Analytics analytics = Analytics();
