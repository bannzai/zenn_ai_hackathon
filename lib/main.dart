import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todomaker/app.dart';
import 'package:todomaker/provider/shared_preferences.dart';
import 'package:todomaker/utils/config/remote_config.dart';
import 'package:todomaker/utils/log/debug_print.dart';

void main() async {
  runZonedGuarded(() async {
    if (kDebugMode) {
      overrideDebugPrint();
    }
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();

    final (sharedPreferences, _) = await (
      SharedPreferences.getInstance(),
      setupRemoteConfig(),
    ).wait;

    // MEMO: FirebaseCrashlytics#recordFlutterError called dumpErrorToConsole in function.
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    setLocaleIdentifier('ja');

    runApp(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWith((ref) => sharedPreferences),
        ],
        child: const App(),
      ),
    );
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
}
