import 'package:flutter/foundation.dart';

abstract class Environment {
  static bool get isProduction {
    return kReleaseMode;
  }

  static bool get isDevelopment {
    return kDebugMode;
  }
}
